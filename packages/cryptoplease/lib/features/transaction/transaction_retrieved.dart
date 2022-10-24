import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'transaction_retrieved.freezed.dart';

@freezed
class TransactionRetrievedStatus with _$TransactionRetrievedStatus {
  const factory TransactionRetrievedStatus.pending() = _Pending;
  const factory TransactionRetrievedStatus.fetched() = _Fetched;
}

@freezed
class TransactionRetrieved with _$TransactionRetrieved {
  const factory TransactionRetrieved({
    required TransactionId id,
    required DateTime? created,
    required String encodedTx,
    required TransactionRetrievedStatus status,
  }) = _TransactionRetrieved;
}
