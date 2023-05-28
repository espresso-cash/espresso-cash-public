import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'app_bar.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.url,
  });

  final Uri url;

  @override
  State<WebViewScreen> createState() => _State();
}

class _State extends State<WebViewScreen> {
  late final WebViewController _controller;
  String? _title;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(widget.url)
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
      return;
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
