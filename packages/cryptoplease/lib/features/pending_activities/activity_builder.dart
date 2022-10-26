import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/repository.dart';
import 'package:cryptoplease/features/pending_activities/activity.dart';

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
