import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap_transaction_set.freezed.dart';

@freezed
class SwapTransactionSet with _$SwapTransactionSet {
  const factory SwapTransactionSet({
    required String? setupTransaction,
    required String swapTransaction,
    required String? cleanupTransaction,
  }) = _SwapTransactionSet;

  const SwapTransactionSet._();
}
