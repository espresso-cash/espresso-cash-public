import '../../../di.dart';
import '../models/payment_request.dart';
import 'repository.dart';

Stream<PaymentRequest> watchPaymentRequest(String id) =>
    sl<PaymentRequestRepository>().watchById(id);
