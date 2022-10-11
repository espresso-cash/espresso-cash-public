import 'package:cryptoplease/features/outgoing_direct_payments/bl/outgoing_direct_payment.dart';

abstract class ODPRepository {
  Future<void> save(OutgoingDirectPayment payment);
  Future<OutgoingDirectPayment?> load(String id);
  Stream<OutgoingDirectPayment?> watch(String id);
  Future<void> clear();
}
