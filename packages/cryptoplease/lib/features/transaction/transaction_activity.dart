import 'package:cryptoplease/features/outgoing_direct_payments/bl/outgoing_direct_payment.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/outgoing_split_key_payment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_activity.freezed.dart';

@freezed
class TransactionActivity with _$TransactionActivity {
  const factory TransactionActivity.outgoingPaymentRequest({
    required String id,
    required DateTime created,
  }) = OPRTransactionActivity;

  const factory TransactionActivity.outgoingDirectPayment({
    required String id,
    required DateTime created,
    required OutgoingDirectPayment data,
  }) = ODPTransactionActivity;

  const factory TransactionActivity.outgoingSplitKeyPayment({
    required String id,
    required DateTime created,
    required OutgoingSplitKeyPayment data,
  }) = OSKPTransactionActivity;
}
