import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

import '../l10n/l10n.dart';
import '../routes.gr.dart';
import 'app_bar.dart';

@RoutePage()
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.url,
    this.title,
    this.onLoaded,
  });

  static const route = WebViewRoute.new;

  final Uri url;
  final String? title;
  final ValueSetter<InAppWebViewController>? onLoaded;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  String? _title;

  Future<void> _handleLoaded(InAppWebViewController controller) async {
    widget.onLoaded?.call(controller);

    if (widget.title != null) return;

    final title = await controller.getTitle();
    if (!mounted) return;

    setState(() => _title = title ?? '');
  }

  Future<PermissionResponse?> _handlePermissionRequest(
    List<PermissionResourceType> resources,
  ) async {
    if (!resources.contains(PermissionResourceType.CAMERA)) {
      return null;
    }

    if (await Permission.camera.request().isGranted) {
      return PermissionResponse(
        resources: resources,
        action: PermissionResponseAction.GRANT,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          title: Text(widget.title ?? _title ?? context.l10n.loading),
        ),
        body: SafeArea(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri.uri(widget.url)),
            onPermissionRequest: (_, permissionRequest) =>
                _handlePermissionRequest(permissionRequest.resources),
            onLoadStop: (controller, _) => _handleLoaded(controller),
            initialSettings: InAppWebViewSettings(
              iframeAllowFullscreen: false,
              allowsInlineMediaPlayback: true,
              allowUniversalAccessFromFileURLs: true,
            ),
          ),
        ),
      );
}
