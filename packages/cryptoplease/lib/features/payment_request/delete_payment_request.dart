import '../../di.dart';
import 'src/bl/repository.dart';

Future<void> deletePaymentRequest(String id) =>
    sl<PaymentRequestRepository>().delete(id);
