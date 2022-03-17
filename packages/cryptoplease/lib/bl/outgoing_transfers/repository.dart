import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

abstract class OutgoingTransferRepository {
  Future<void> save(OutgoingTransfer payment);
  Future<OutgoingTransfer> getById(String id);
  Stream<IList<OutgoingTransfer>> watchPayments();
  Stream<OutgoingTransfer> watchPayment(String id);
  Future<void> addFirstLink(String id, Uri link);
  Future<void> clear();
}
