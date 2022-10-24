import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'transaction_activity.freezed.dart';

@freezed
class TransactionActivityStatus with _$TransactionActivityStatus {
  const factory TransactionActivityStatus.pending() = TASPending;
  const factory TransactionActivityStatus.fetched() = TASFetched;
}

@freezed
class TransactionActivity with _$TransactionActivity {
  const factory TransactionActivity({
    required TransactionId id,
    required DateTime? created,
    required String encodedTx,
    required TransactionActivityStatus status,
  }) = _TransactionActivity;
}
