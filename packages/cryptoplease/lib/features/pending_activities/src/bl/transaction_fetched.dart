import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'transaction_fetched.freezed.dart';

@freezed
class TransactionFetchedStatus with _$TransactionFetchedStatus {
  const factory TransactionFetchedStatus.pending() = _Pending;
  const factory TransactionFetchedStatus.downloaded() = _Downloaded;
}

@freezed
class TransactionFetched with _$TransactionFetched {
  const factory TransactionFetched({
    required TransactionId id,
    required DateTime? created,
    required String encodedTx,
    required TransactionFetchedStatus status,
  }) = _TransactionFetched;
}
