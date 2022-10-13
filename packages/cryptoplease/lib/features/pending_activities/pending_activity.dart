import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_activity.freezed.dart';

@freezed
class PendingActivity with _$PendingActivity {
  const factory PendingActivity.outgoingPaymentRequest({
    required String id,
    required DateTime created,
  }) = OPRPendingActivity;

  const factory PendingActivity.outgoingDirectPayment({
    required String id,
    required DateTime created,
  }) = ODPPendingActivity;

  const factory PendingActivity.outgoingSplitKeyPayment({
    required String id,
    required DateTime created,
  }) = OSKPPendingActivity;
}
