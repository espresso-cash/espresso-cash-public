import 'package:cryptoplease/features/payment_request/bl/payment_request.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

abstract class PaymentRequestRepository {
  Future<void> save(PaymentRequest payment);
  Stream<IList<Product2<String, DateTime>>> watchAllIds();
  Stream<PaymentRequest> watchById(String id);
  Future<void> clear();
}
