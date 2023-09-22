import 'package:injectable/injectable.dart';

import '../config.dart';

@injectable
class LinkShortener {
  const LinkShortener();

  Uri buildFullUrl(Uri link) => Uri(
        scheme: 'https',
        host: espressoCashDeepLinkHost,
        path: '/',
        queryParameters: <String, String>{
          'link': link.toString(),
        },
      );
}
