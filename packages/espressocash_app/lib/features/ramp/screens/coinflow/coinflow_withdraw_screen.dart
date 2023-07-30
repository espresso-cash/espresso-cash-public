import 'package:auto_route/auto_route.dart';
import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../config.dart';
import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/app_bar.dart';
import '../../../accounts/models/account.dart';
import '../../widgets/extensions.dart';
import '../off_ramp_confirmation_screen.dart';
import '../off_ramp_details_screen.dart';

@RoutePage()
class CoinflowOffRampScreen extends StatefulWidget {
  const CoinflowOffRampScreen({super.key});

  static const route = CoinflowOffRampRoute.new;

  @override
  State<CoinflowOffRampScreen> createState() => _State();
}

class _State extends State<CoinflowOffRampScreen> {
  late final WebViewController _controller;

  static const _channelName = 'coinflowChannel';

  @override
  void initState() {
    super.initState();

    final userAddress = context.read<MyAccount>().wallet.publicKey.toBase58();

    final uri = _buildUri(userAddress: userAddress);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(uri)
      ..addJavaScriptChannel(
        _channelName,
        onMessageReceived: _onMessageReceived,
      );
  }

  Future<void> _onMessageReceived(JavaScriptMessage message) async {
    final tx = message.message.let(SignedTx.decode);

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
          _controller.runJavaScript('fromFlutter("${tx.id}")');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          title: const Text('Coinflow | Espresso Cash'),
        ),
        body: WebViewWidget(controller: _controller),
      );
}

Uri _buildUri({required String userAddress}) => Uri(
      scheme: 'http', // TODO(Justin): update url once deployed
      host: coinflowHost,
      port: 3000, // TODO(Justin): update url once deployed
      path: '/',
      queryParameters: <String, String>{
        'publicKey': userAddress,
        'cluster': isProd ? 'prod' : 'staging',
      },
    );
