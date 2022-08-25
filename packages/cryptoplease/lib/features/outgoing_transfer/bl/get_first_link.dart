import 'package:cryptoplease/features/incoming_split_key_payment/bl/models.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<Uri> getFirstLink(
  OutgoingTransferSplitKey transfer, {
  required OutgoingTransferRepository repository,
}) async {
  var firstLink = transfer.firstLink;
  if (firstLink == null) {
    firstLink = buildFirstLink(
      transfer.privateKey,
      transfer.tokenAddress,
      transfer.apiReference.name,
    );
    final firebaseLink = await FirebaseDynamicLinks.instance.buildShortLink(
      DynamicLinkParameters(
        link: firstLink,
        uriPrefix: 'https://cryptoplease.page.link',
        androidParameters: const AndroidParameters(
          packageName: 'com.pleasecrypto.flutter',
        ),
        iosParameters: const IOSParameters(
          bundleId: 'com.pleasecrypto.flutter',
          appStoreId: '1559625715',
        ),
      ),
    );
    firstLink = firebaseLink.shortUrl;
    await repository.addFirstLink(transfer.id, firstLink);
  }

  return firstLink;
}
