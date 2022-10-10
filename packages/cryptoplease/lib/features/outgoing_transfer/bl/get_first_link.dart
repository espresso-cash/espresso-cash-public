import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/payments/split_key_payments/split_key_api_version.dart';
import 'package:cryptoplease/core/split_key_payments.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_transfer_status_bloc/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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
      transfer.apiVersion,
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

Uri buildFirstLink(
  IList<int> privateKey,
  String tokenAddress,
  SplitKeyApiVersion apiVersion,
) =>
    Uri(
      scheme: 'https',
      host: link1Host,
      path: '/',
      queryParameters: <String, String>{
        'key': splitKey(privateKey).first,
        if (tokenAddress != Token.sol.address) 'token': tokenAddress,
        'v': apiVersion.name,
      },
    );

Uri buildSecondLink(IList<int> privateKey) =>
    SplitKeySecondLink(key: splitKey(privateKey).last).uri;

extension on SplitKeySecondLink {
  Uri get uri => Uri.parse('https://$link2Host/?key=$key');
}
