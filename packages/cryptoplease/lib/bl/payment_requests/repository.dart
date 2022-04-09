import 'package:cryptoplease/bl/payment_requests/payment_request.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

abstract class PaymentRequestRepository {
  Future<void> save(PaymentRequest payment);
  Stream<IList<String>> getAllIds();
  Stream<PaymentRequest> getById(String id);
}
