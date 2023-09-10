import 'package:freezed_annotation/freezed_annotation.dart';

import '../../outgoing_direct_payments/models/outgoing_direct_payment.dart';
import '../../outgoing_split_key_payments/models/outgoing_split_key_payment.dart';
import '../../ramp/ramp.dart';
import '../../swap/models/swap.dart';

part 'activity.freezed.dart';

@freezed
class Activity with _$Activity {
  const factory Activity.outgoingPaymentRequest({
    required String id,
    required DateTime created,
  }) = OPRActivity;

  const factory Activity.outgoingDirectPayment({
    required String id,
    required DateTime created,
    required OutgoingDirectPayment data,
  }) = ODPActivity;

  const factory Activity.outgoingSplitKeyPayment({
    required String id,
    required DateTime created,
    required OutgoingSplitKeyPayment data,
  }) = OSKPActivity;

  const factory Activity.swap({
    required String id,
    required DateTime created,
    required Swap data,
  }) = SwapActivity;

  const factory Activity.offRampPayment({
    required String id,
    required DateTime created,
    required OffRampPayment data,
  }) = ORPActivity;
}
