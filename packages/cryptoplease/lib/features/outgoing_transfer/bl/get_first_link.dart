import 'package:cryptoplease/features/incoming_split_key_payment/bl/models.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';

Future<Uri> getFirstLink(
  OutgoingTransferSplitKey transfer, {
  required OutgoingTransferRepository repository,
}) async {
  var firstLink = transfer.firstLink;
  if (firstLink == null) {
    firstLink = buildFirstLink(transfer.privateKey, transfer.tokenAddress);
    await repository.addFirstLink(transfer.id, firstLink);
  }

  return firstLink;
}
