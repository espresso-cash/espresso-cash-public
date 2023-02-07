import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

import '../src/activity.dart';

part 'transaction.freezed.dart';

enum TxCommonStatus { success, failure }

@freezed
class Transaction with _$Transaction {
  const factory Transaction.common(
    SignedTx tx, {
    required TxCommonStatus status,
    required DateTime? created,
  }) = TxCommon;

  const factory Transaction.activity(Activity activity) = TxActivity;
}
