import 'package:cryptoplease/features/pending_activities/activity.dart';
import 'package:cryptoplease/features/transaction/bl/transaction_fetched.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction.common(TransactionFetched fetched) = TxCommon;

  const factory Transaction.activity(Activity activity) = TxActivity;
}
