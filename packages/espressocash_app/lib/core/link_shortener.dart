import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../config.dart';

@injectable
class LinkShortener {
  const LinkShortener();

  final _androidParameters = const AndroidParameters(
    packageName: 'com.pleasecrypto.flutter',
  );

  final _iosParameters = const IOSParameters(
    bundleId: 'com.pleasecrypto.flutter',
    appStoreId: '1559625715',
  );

  Future<Uri?> buildShortUrl(Uri link) async {
    final parameters = DynamicLinkParameters(
      link: link,
      uriPrefix: 'https://$espressoCashDeepLinkHost',
      androidParameters: _androidParameters,
      iosParameters: _iosParameters,
    );

    try {
      await http.get(parameters.link);

      final link =
          await FirebaseDynamicLinks.instance.buildShortLink(parameters);

      return link.shortUrl;
    } on Object {
      return null;
    }
  }

  Uri buildFullUrl(Uri link) => Uri(
        scheme: 'https',
        host: espressoCashDeepLinkHost,
        path: '/',
        queryParameters: <String, String>{
          'apn': _androidParameters.packageName,
          'ibi': _iosParameters.bundleId,
          'isi': _iosParameters.appStoreId ?? '',
          'link': link.toString(),
        },
      );

  static Future<Uri?> reverse(String? link) async {
    if (link == null) return null;

    final url = Uri.tryParse(link);
    if (url == null) return null;

    return FirebaseDynamicLinks.instance
        .getDynamicLink(url)
        .then((it) => it?.link)
        .catchError((_) => null);
  }
}
