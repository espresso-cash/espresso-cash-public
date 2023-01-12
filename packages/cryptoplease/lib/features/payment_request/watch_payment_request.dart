import '../../di.dart';
import 'models/payment_request.dart';
import 'src/bl/repository.dart';

Stream<PaymentRequest> watchPaymentRequest(String id) =>
    sl<PaymentRequestRepository>().watchById(id);
