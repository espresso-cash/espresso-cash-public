import 'package:cryptoplease/features/incoming_split_key_payments/bl/incoming_split_key_payment.dart';

abstract class ISKPRepository {
  Future<void> save(IncomingSplitKeyPayment payment);
  Future<IncomingSplitKeyPayment?> load(String id);
  Stream<IncomingSplitKeyPayment?> watch(String id);
  Future<void> clear();
}
