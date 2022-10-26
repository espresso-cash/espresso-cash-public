import 'package:cryptoplease/features/outgoing_direct_payments/bl/outgoing_direct_payment.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/outgoing_split_key_payment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
}
