import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
class LinkShortener {
  //TODO to delete if not gonna use
  const LinkShortener();

  Future<Uri?> shorten(Uri link) async {
    final parameters = DynamicLinkParameters(
      link: link,
      uriPrefix: 'https://cryptoplease.page.link',
      androidParameters: const AndroidParameters(
        packageName: 'com.pleasecrypto.flutter',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.pleasecrypto.flutter',
        appStoreId: '1559625715',
      ),
    );

    try {
      await http.get(parameters.link);

      return FirebaseDynamicLinks.instance
          .buildShortLink(parameters)
          .then((it) => it.shortUrl);
    } on Object {
      return null;
    }
  }
}
