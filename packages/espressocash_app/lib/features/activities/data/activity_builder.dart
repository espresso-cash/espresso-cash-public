import '../../../data/db/db.dart';
import '../../outgoing_direct_payments/data/repository.dart';
import '../../outgoing_dln_payments/data/repository.dart';
import '../../outgoing_link_payments/data/repository.dart';
import '../../tokens/token_list.dart';
import '../../transaction_request/models/transaction_request.dart';
import '../models/activity.dart';

extension PaymentRequestRowToActivityExt on PaymentRequestRow {
  Activity toActivity() => Activity.outgoingPaymentRequest(
        id: id,
        created: created,
      );
}

extension ODPRowToActivityExt on ODPRow {
  Activity toActivity(TokenList tokens) => Activity.outgoingDirectPayment(
        id: id,
        created: created,
        data: toModel(tokens),
      );
}

extension OutgoingDlnPaymentRowToActivityExt on OutgoingDlnPaymentRow {
  Activity toActivity() => Activity.outgoingDlnPayment(
        id: id,
        created: created,
        data: toModel(),
      );
}

extension OLPRowToActivityExt on OLPRow {
  Activity toActivity(TokenList tokens) => Activity.outgoingLinkPayment(
        id: id,
        created: created,
        data: toModel(tokens),
      );
}

extension TransactionRequestPaymentExt on TransactionRequestPayment {
  Activity toActivity() => Activity.transactionRequest(
        id: id,
        created: created,
        data: this,
      );
}
