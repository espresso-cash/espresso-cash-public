import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../l10n/l10n.dart';
import 'app_bar.dart';
import 'theme.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.url,
    this.title,
    this.onLoaded,
    this.theme,
  });

  final Uri url;
  final String? title;
  final ValueSetter<InAppWebViewController>? onLoaded;
  final CpThemeData? theme;

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
  Widget build(BuildContext context) {
    final theme = widget.theme ?? const CpThemeData.light();

    return CpTheme(
      theme: theme,
      child: Scaffold(
        appBar: CpAppBar(
          title: Text(widget.title ?? _title ?? context.l10n.loading),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri.uri(widget.url)),
          onPermissionRequest: (_, permissionRequest) =>
              _handlePermissionRequest(permissionRequest.resources),
          onLoadStop: (controller, _) => _handleLoaded(controller),
          initialSettings: InAppWebViewSettings(
            iframeAllowFullscreen: false,
            allowsInlineMediaPlayback: true,
            mediaPlaybackRequiresUserGesture: false,
            underPageBackgroundColor: theme.backgroundColor,
          ),
        ),
      ),
    );
  }
}

class WebViewRoute extends GoRouteData {
  const WebViewRoute(this.$extra);

  final WebViewParams $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => WebViewScreen(
        url: $extra.url,
        title: $extra.title,
        onLoaded: $extra.onLoaded,
        theme: $extra.theme,
      );
}

typedef WebViewParams = ({
  Uri url,
  String? title,
  ValueSetter<InAppWebViewController>? onLoaded,
  CpThemeData? theme,
});
