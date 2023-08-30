import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

import '../routes.gr.dart';
import 'app_bar.dart';

@RoutePage()
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.url,
    this.title,
  });

  static const route = WebViewRoute.new;

  final Uri url;
  final String? title;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  String _title = '';

  Future<void> _handleLoaded(InAppWebViewController controller) async {
    if (widget.title != null) return;

    final title = await controller.getTitle();
    if (!mounted) return;

    setState(() => _title = title ?? '');
  }

  Future<PermissionRequestResponse?> _handleAndroidPermissionRequest(
    List<String> resources,
  ) async {
    if (!resources.contains('android.webkit.resource.VIDEO_CAPTURE')) {
      return null;
    }

    if (await Permission.camera.request().isGranted) {
      return PermissionRequestResponse(
        resources: resources,
        action: PermissionRequestResponseAction.GRANT,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(title: Text(widget.title ?? _title)),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: widget.url),
          androidOnPermissionRequest: (_, __, resources) =>
              _handleAndroidPermissionRequest(resources),
          onLoadStop: (controller, _) => _handleLoaded(controller),
        ),
      );
}
