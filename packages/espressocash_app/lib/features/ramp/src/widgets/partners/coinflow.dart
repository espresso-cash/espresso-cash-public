import 'package:auto_route/auto_route.dart';
import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:solana/encoder.dart';

import '../../../../../config.dart';
import '../../../../../core/amount.dart';
import '../../../../../core/currency.dart';
import '../../../../../di.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../models/ramp_partner.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../services/off_ramp_order_service.dart';
import '../../models/profile_data.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchCoinflowOffRamp({
    required String address,
    required ProfileData profile,
  }) async {
    final uri = Uri.parse(coinflowBaseUrl).replace(
      queryParameters: {
        'publicKey': address,
        'email': profile.email,
        'cluster': isProd ? 'mainnet' : 'staging',
        'rpcUrl': solanaRpcUrl,
      },
    );

    bool orderWasCreated = false;
    void handleLoaded(InAppWebViewController controller) {
      controller.addJavaScriptHandler(
        handlerName: 'coinflow',
        callback: (args) async {
          if (orderWasCreated) return null;

          if (args.first is! String) return null;

          final encodedTx = args.first as String;

          final tx = encodedTx.let(SignedTx.decode);
          final ix = tx.decompileMessage().instructions.first.data;

          final reader = BinaryReader(
            Uint8List.fromList(ix.toList()).buffer.asByteData(),
          )..offset = 1;

          final amount = reader.readU64().toInt().let(
                (e) => CryptoAmount(
                  value: e,
                  cryptoCurrency: Currency.usdc,
                ),
              );

          await sl<OffRampOrderService>()
              .createFromTx(
            tx: tx,
            amount: amount,
            partner: RampPartner.coinflow,
          )
              .then((order) {
            switch (order) {
              case Left<Exception, String>():
                break;
              case Right<Exception, String>(:final value):
                router.replace(OffRampOrderScreen.route(orderId: value));
            }
          });

          orderWasCreated = true;

          return tx.id;
        },
      );
    }

    await router.push(WebViewScreen.route(url: uri, onLoaded: handleLoaded));
  }
}
