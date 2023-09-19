import 'package:injectable/injectable.dart';

import '../config.dart';

@injectable
class LinkShortener {
  const LinkShortener();

  // final _androidParameters = const AndroidParameters(
  //   packageName: 'com.pleasecrypto.flutter',
  // );

  // final _iosParameters = const IOSParameters(
  //   bundleId: 'com.pleasecrypto.flutter',
  //   appStoreId: '1559625715',
  // );

  Uri buildFullUrl(Uri link) => Uri(
        scheme: 'https',
        host: espressoCashDeepLinkHost,
        path: '/',
        queryParameters: <String, String>{
          'apn': 'com.pleasecrypto.flutter',
          'ibi': 'com.pleasecrypto.flutter',
          'isi': '1559625715',
          'link': link.toString(),
        },
      );
}
