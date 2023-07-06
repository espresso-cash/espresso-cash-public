import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../config.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/app_bar.dart';
import '../../../accounts/models/account.dart';
import '../../widgets/extensions.dart';

@RoutePage()
class CoinflowOffRampScreen extends StatefulWidget {
  const CoinflowOffRampScreen({
    super.key,
  });

  @override
  State<CoinflowOffRampScreen> createState() => _State();
}

class _State extends State<CoinflowOffRampScreen> {
  late final WebViewController _controller;

  final channelName = 'flutterChannel';

  @override
  void initState() {
    super.initState();

    final userAddress = context.read<MyAccount>().wallet.publicKey.toBase58();

    final uri = _buildUri(userAddress: userAddress);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(uri)
      ..addJavaScriptChannel(channelName, onMessageReceived: onMessageReceived)
      ..setNavigationDelegate(
        NavigationDelegate(onPageFinished: (_) => _onPageFinished()),
      );
  }

  Future<void> onMessageReceived(
    JavaScriptMessage message,
  ) async {
    // final tx = await message.message
    //     .let(SignedTx.decode)
    //     .let((it) => it.resign(context.read<MyAccount>().wallet));

    // final txSender = TxSender(client: sl<SolanaClient>());

    // final res = await txSender.send(tx, minContextSlot: BigInt.zero);

    // print(res);

    final confirmed =
        await context.router.push<bool?>(const OffRampConfirmationRoute());

    if (confirmed != true) return;

    final tx = message.message.let(SignedTx.decode);

    if (!mounted) return;
    final id = await context.createORPSigned(tx: tx);

    if (!mounted) return;
    await context.router.push(
      OffRampDetailsRoute(
        id: id,
        onSuccess: () {
          _controller.runJavaScript('fromFlutter("${tx.id}")');
        },
      ),
    );
  }

  Future<void> _onPageFinished() async {
    try {
      //TODO check if needed
      if (!mounted) return;
    } on Exception {
      // ignore
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          title: const Text('Coinflow | Espresso Cash'),
        ),
        body: WebViewWidget(
          controller: _controller,
        ),
      );
}

Uri _buildUri({required String userAddress}) => Uri(
      scheme: 'http',
      host: 'localhost',
      port: 3000,
      path: '/',
      queryParameters: <String, String>{
        'publicKey': userAddress,
        'cluster': isProd ? 'prod' : 'staging',
      },
    );
