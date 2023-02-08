import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';
import '../../outgoing_direct_payments/db.dart';
import '../../outgoing_split_key_payments/db.dart';
import '../../swap/db.dart';
import 'activity.dart';

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

extension OSKPRowToActivityExt on OSKPRow {
  Future<Activity> toActivity(TokenList tokens) async =>
      Activity.outgoingSplitKeyPayment(
        id: id,
        created: created,
        data: await toModel(tokens),
      );
}

extension SwapRowToActivityExt on SwapRow {
  Activity toActivity(TokenList tokens) => Activity.swap(
        id: id,
        created: created,
        data: toModel(tokens),
      );
}
