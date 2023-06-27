import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../di.dart';
import '../../../../ui/app_bar.dart';
import '../../../accounts/models/account.dart';
import '../../../transactions/services/resign_tx.dart';
import '../../../transactions/services/tx_sender.dart';

@RoutePage()
class CoinflowOffRampScreen extends StatefulWidget {
  const CoinflowOffRampScreen({
    super.key,
    required this.url,
  });

  final Uri url;

  @override
  State<CoinflowOffRampScreen> createState() => _State();
}

class _State extends State<CoinflowOffRampScreen> {
  late final WebViewController _controller;
  String? _title;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(widget.url)
      ..addJavaScriptChannel(
        'flutterChannel',
        onMessageReceived: (message) async {
          final tx = await message.message
              .let(SignedTx.decode)
              .let((it) => it.resign(context.read<MyAccount>().wallet));

          final txSender = TxSender(client: sl<SolanaClient>());

          final res = await txSender.send(tx, minContextSlot: BigInt.zero);

          print(res);

          await _controller.runJavaScript('fromFlutter("${tx.id}")');
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(onPageFinished: (_) => _onPageFinished()),
      );
  }

  Future<void> _onPageFinished() async {
    try {
      final title = await _controller.getTitle();
      if (!mounted) return;
      setState(() => _title = title);
    } on Exception {
      // ignore
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          title: Text(_title ?? ''),
        ),
        body: WebViewWidget(
          controller: _controller,
        ),
      );
}
