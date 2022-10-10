import 'package:cryptoplease/features/outgoing_split_key_payments/bl/outgoing_split_key_payment.dart';

abstract class OSKPRepository {
  Future<void> save(OutgoingSplitKeyPayment payment);
  Future<OutgoingSplitKeyPayment?> load(String id);
  Stream<OutgoingSplitKeyPayment?> watch(String id);
  Future<void> clear();
}
