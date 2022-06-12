import 'dart:io';

import 'package:collection/collection.dart';
import 'package:cryptoplease_link/src/app.dart';
import 'package:cryptoplease_link/src/apps.dart';
import 'package:cryptoplease_link/src/platform.dart';
import 'package:mustache_template/mustache.dart';
import 'package:shelf/shelf.dart';

Future<Response> commonHandler(
  Request request, {
  required String templateName,
  required Map<String, dynamic> Function(Map<String, dynamic>) updateData,
}) async {
  final appId = request.url.queryParameters['appId']?.toLowerCase();

  final platform = request.platform;

  final candidate =
      apps.firstWhereOrNull((a) => a.id == appId) ?? cryptoPleaseApp;
  final App app;
  switch (platform) {
    case Platform.android:
      app = candidate.androidOptions == null ? cryptoPleaseApp : candidate;
      break;
    case Platform.ios:
      app = candidate.iOSOptions == null ? cryptoPleaseApp : candidate;
      break;
    case Platform.web:
      app = candidate;
      break;
  }

  final template = Template(
    File('templates/$templateName.html').readAsStringSync(),
    partialResolver: (p) => Template(
      File('templates/partials/$p').readAsStringSync(),
    ),
    htmlEscapeValues: false,
  );

  final deepLink = request.requestedUri;
  // ignore: avoid-non-null-assertion, should not be null at this point
  final String installLink = app.installLink(deepLink, platform)!;

  final bool shouldCopy;
  switch (platform) {
    case Platform.android:
      shouldCopy = false;
      break;
    case Platform.ios:
      shouldCopy = true;
      break;
    case Platform.web:
      shouldCopy = false;
      break;
  }

  final data = <String, dynamic>{
    'installLink': installLink,
    'shouldCopy': shouldCopy,
    'appName': app.name,
    'deepLink': deepLink.toString(),
    'apps': apps
        .map(
          (a) => <String, dynamic>{
            'name': a.name,
            'url': a.installLink(deepLink, platform),
            'textColor': a.appDisplayStyle.textColor,
            'backgroundColor': a.appDisplayStyle.backgroundColor,
            'logoUri': a.appDisplayStyle.logoUri,
          },
        )
        .where((a) => a['url'] != null),
  };

  return Response.ok(
    template.renderString(updateData(data)),
    headers: {'Content-Type': 'text/html'},
  );
}

extension on App {
  String? installLink(Uri deepLink, Platform platform) {
    switch (platform) {
      case Platform.android:
        return _androidInstallLink(deepLink);
      case Platform.ios:
        return _iosInstallLink();
      case Platform.web:
        return url.toString();
    }
  }

  String? _androidInstallLink(Uri deepLink) {
    final appId = androidOptions?.package;
    if (appId == null) return null;

    final browserFallbackUrl = Uri(
      scheme: 'https',
      host: 'play.google.com',
      path: '/store/apps/details',
      queryParameters: <String, dynamic>{
        'id': appId,
        'referrer': Uri.encodeComponent(deepLink.toString()),
      },
    );
    final intent = '#Intent;'
        'package=$appId;'
        'scheme=https;'
        'S.browser_fallback_url=${Uri.encodeComponent(browserFallbackUrl.toString())};'
        'end';

    return '${deepLink.replace(scheme: 'intent')}$intent';
  }

  String? _iosInstallLink() {
    final appId = iOSOptions?.appStoreId;
    if (appId == null) return null;

    return Uri(
      scheme: 'https',
      host: 'itunes.apple.com',
      path: '/app/id$appId',
    ).toString();
  }
}
