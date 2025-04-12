import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
import '../utils/errors.dart';
import 'app_bar.dart';
import 'snackbar.dart';
import 'theme.dart';

extension LinkOpenerExt on BuildContext {
  Future<void> openLink(String link, {bool openInApp = false}) async {
    try {
      final url = Uri.parse(link);

      if (openInApp) {
        final launched = await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);

        if (launched) return;
      }

      await WebViewScreen.push(this, url: url, title: null, onLoaded: null, theme: null);
    } on FormatException catch (_) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);
    }
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.url,
    this.title,
    this.onLoaded,
    CpThemeData? theme,
    this.onClosed,
  }) : theme = theme ?? const CpThemeData.black();

  static Future<void> push(
    BuildContext context, {
    required Uri url,
    String? title,
    ValueSetter<InAppWebViewController>? onLoaded,
    VoidCallback? onClosed,
    CpThemeData? theme,
  }) => Navigator.of(context).push<void>(
    MaterialPageRoute(
      builder:
          (context) => WebViewScreen(
            url: url,
            title: title,
            onLoaded: onLoaded,
            theme: theme,
            onClosed: onClosed,
          ),
    ),
  );

  final Uri url;
  final String? title;
  final ValueSetter<InAppWebViewController>? onLoaded;
  final VoidCallback? onClosed;
  final CpThemeData? theme;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  String? _title;

  Future<void> _handleLoaded(InAppWebViewController controller) async {
    widget.onLoaded?.call(controller);

    final title = widget.title ?? await controller.getTitle() ?? '';
    if (!mounted) return;

    setState(() => _title = title);
  }

  Future<PermissionResponse?> _handlePermissionRequest(
    List<PermissionResourceType> resources,
  ) async {
    if (!resources.contains(PermissionResourceType.CAMERA)) {
      return null;
    }

    if (await Permission.camera.request().isGranted) {
      return PermissionResponse(resources: resources, action: PermissionResponseAction.GRANT);
    }
  }

  void _handleWindowClosed() {
    final onClosed = widget.onClosed;

    if (onClosed != null) {
      onClosed();
    } else {
      Navigator.pop(context);
    }
  }

  void _handleError(String type, String details, [String? url]) {
    final error = WebViewException(type: type, details: details, url: url);
    reportWebViewError(error);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? const CpThemeData.light();

    return CpTheme(
      theme: theme,
      child: Scaffold(
        appBar: CpAppBar(title: Text(_title ?? context.l10n.loading)),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri.uri(widget.url)),
          onPermissionRequest:
              (_, permissionRequest) => _handlePermissionRequest(permissionRequest.resources),
          onLoadStop: (controller, _) => _handleLoaded(controller),
          onCloseWindow: (_) => _handleWindowClosed(),
          onConsoleMessage: (controller, consoleMessage) async {
            if (consoleMessage.messageLevel != ConsoleMessageLevel.ERROR) {
              return;
            }

            final url = await controller.getUrl();

            _handleError('Console', consoleMessage.message, url?.toString());
          },
          onReceivedError:
              (_, request, error) =>
                  _handleError('JavaScript', error.toString(), request.url.toString()),
          onReceivedHttpError:
              (_, request, error) => _handleError('HTTP', error.toString(), request.url.toString()),
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

class WebViewException implements Exception {
  const WebViewException({required this.type, required this.details, this.url});

  final String type;
  final String details;
  final String? url;

  @override
  String toString() =>
      ['WebView $type Error:', details, if (url case final url?) 'URL: $url'].join('\n');
}
