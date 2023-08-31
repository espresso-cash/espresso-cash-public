import 'package:auto_route/auto_route.dart';
import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:solana/encoder.dart';

import '../../../../config.dart';
import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/app_bar.dart';
import '../../models/profile_data.dart';
import '../../widgets/extensions.dart';
import '../off_ramp_confirmation_screen.dart';
import '../off_ramp_details_screen.dart';

@RoutePage()
class CoinflowOffRampScreen extends StatefulWidget {
  const CoinflowOffRampScreen({
    super.key,
    required this.profile,
    required this.address,
  });

  final ProfileData profile;
  final String address;

  static const route = CoinflowOffRampRoute.new;

  @override
  State<CoinflowOffRampScreen> createState() => _State();
}

class _State extends State<CoinflowOffRampScreen> {
  static const _channelName = 'coinflowChannel';

  late final Uri uri =
      _buildUri(userAddress: widget.address, email: widget.profile.email);

  Future<void> _onMessageReceived(
    InAppWebViewController controller, {
    required String encodedTx,
  }) async {
    final tx = encodedTx.let(SignedTx.decode);

    final data = tx.decompileMessage().instructions.first.data;

    final reader = BinaryReader(
      Uint8List.fromList(data.toList()).buffer.asByteData(),
    )..offset = 1;

    final value = reader.readU64().toInt();

    final amount = CryptoAmount(
      value: value,
      cryptoCurrency: Currency.usdc,
    );

    final confirmed = await context.router.push<bool?>(
      OffRampConfirmationScreen.route(
        provider: 'Coinflow',
        amount: amount,
      ),
    );

    if (confirmed != true) return;

    if (!mounted) return;
    final id = await context.createORP(
      tx: tx,
      provider: 'coinflow',
      amount: amount,
    );

    if (!mounted) return;
    await context.router.push(
      OffRampDetailsScreen.route(
        id: id,
        onSuccess: () {
          controller.evaluateJavascript(source: 'fromFlutter("${tx.id}")');
        },
      ),
    );
  }

  Future<void> _handleLoaded(InAppWebViewController controller) async {
    controller.addJavaScriptHandler(
      handlerName: _channelName,
      callback: (args) async {
        if (args.isNotEmpty && args.first is String) {
          await _onMessageReceived(
            controller,
            encodedTx: args.first as String,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          title: const Text('Coinflow | Espresso Cash'),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: uri),
          onLoadStop: (controller, _) => _handleLoaded(controller),
        ),
      );
}

Uri _buildUri({required String userAddress, required String email}) =>
    Uri.parse(coinflowAppUrl).replace(
      queryParameters: <String, String>{
        'publicKey': userAddress,
        'email': email,
        'cluster': isProd ? 'mainnet' : 'staging',
        'rpcUrl': solanaRpcUrl,
      },
    );
