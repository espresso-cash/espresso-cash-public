import 'package:freezed_annotation/freezed_annotation.dart';

import 'activity.dart';
import 'bl/transaction_fetched.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction.common(TransactionFetched fetched) = TxCommon;

  const factory Transaction.activity(Activity activity) = TxActivity;
}
