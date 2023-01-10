import '../../di.dart';
import 'models/payment_request.dart';
import 'src/bl/repository.dart';

Future<void> deletePaymentRequest(PaymentRequest payment) =>
    sl<PaymentRequestRepository>().delete(payment);
