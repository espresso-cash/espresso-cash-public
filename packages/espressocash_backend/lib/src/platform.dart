import 'package:shelf/shelf.dart';

enum Platform {
  android,
  ios,
  web,
}

extension RequestExt on Request {
  Platform get platform {
    final userAgent = headers['User-Agent'] ?? '';

    if (userAgent.contains('iPhone') || userAgent.contains('iPad')) {
      return Platform.ios;
    } else if (userAgent.contains('Android')) {
      return Platform.android;
    }

    return Platform.web;
  }
}
