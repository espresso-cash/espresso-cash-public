import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config.dart';
import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/theme.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../tokens/token.dart';
import '../../../../transaction_request/widgets/solana_client_ext.dart';
import '../../../models/profile_data.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../services/off_ramp_order_service.dart';
import '../data/coinflow_api_client.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchCoinflowOffRamp({
    required String address,
    required ProfileData profile,
  }) async {
    final hasKYC = await _checkKYC(address: address);

    switch (hasKYC) {
      case Left<Exception, bool>(:final value):
        final exception = value as DioException;

        if (exception.response?.statusCode == 451) {
          final verificationLink = (exception.response?.data
              as Map<String, dynamic>)['verificationLink'] as String?;

          if (verificationLink != null) {
            await _launchUrl(Uri.parse(verificationLink));

            return;
          }
        }

        showCpErrorSnackbar(this, message: l10n.tryAgainLater);

        return;

      case Right<Exception, bool>(:final value):
        if (!value) {
          await _launchUrl(
            _buildKycUrl(address: address, email: profile.email),
          );

          return;
        }
    }

    final blank = Uri.parse('about:blank');

    bool orderWasCreated = false;
    bool hasLoaded = false;

    Future<void> handleLoaded(InAppWebViewController controller) async {
      if (!hasLoaded) {
        await controller.loadFile(
          assetFilePath: 'assets/coinflow/index.html',
        );

        controller.addJavaScriptHandler(
          handlerName: 'init',
          callback: (args) => {
            'publicKey': address,
            'email': profile.email,
            'cluster': isProd ? 'mainnet' : 'staging',
            'rpcUrl': solanaRpcUrl,
            'token': Token.usdc.address,
          },
        );

        hasLoaded = true;
      }

      controller.addJavaScriptHandler(
        handlerName: 'coinflow',
        callback: (args) async {
          if (orderWasCreated) return null;

          if (args.first is! String) return null;

          const currency = Currency.usdc;

          final encodedTx = args.first as String;
          final tx = encodedTx.let(SignedTx.decode);
          final txData = await sl<SolanaClient>().simulateTransfer(
            tx: tx,
            account: Ed25519HDPublicKey.fromBase58(address),
            currency: currency,
          );

          if (txData == null) {
            throw Exception('Failed to calculate tx data');
          }

          await sl<OffRampOrderService>()
              .createFromTx(
            tx: tx,
            slot: txData.slot,
            amount: CryptoAmount(
              value: txData.amountTransferred,
              cryptoCurrency: currency,
            ),
            partner: RampPartner.coinflow,
          )
              .then((order) {
            switch (order) {
              case Left<Exception, String>():
                break;
              case Right<Exception, String>(:final value):
                OffRampOrderScreen.pushReplacement(this, id: value);
            }
          });

          orderWasCreated = true;

          return tx.id;
        },
      );
    }

    await WebViewScreen.push(
      this,
      url: blank,
      onLoaded: handleLoaded,
      title: l10n.ramp_titleCashOut,
      theme: const CpThemeData.black(),
    );
  }

  AsyncResult<bool> _checkKYC({required String address}) =>
      runWithLoader<Result<bool>>(this, () async {
        try {
          final client = sl<CoinflowClient>();

          final response = await client.getWithdrawer(address);

          return Either.right(response.withdrawer.hasLinkedAccounts);
        } on DioException catch (exception) {
          if (exception.response?.statusCode == 401 ||
              exception.response?.statusCode == 412) {
            return const Either.right(false);
          }

          return Either.left(exception);
        }
      });

  Uri _buildKycUrl({
    required String address,
    required String email,
  }) {
    final baseUrl = Uri.parse(coinflowKycUrl);

    final coinflowDeepLinkUrl = Uri(
      scheme: espressoCashLinkProtocol,
      host: '',
      path: 'coinflow',
    ).toString();

    return baseUrl.replace(
      queryParameters: {
        'pubkey': address,
        'email': email,
        'bankAccountLinkRedirect': coinflowDeepLinkUrl,
      },
    );
  }
}

Future<void> _launchUrl(Uri url) => launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
