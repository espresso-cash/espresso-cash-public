part of 'transaction_item_bloc.dart';

enum TransactionType { incoming, outgoing, unknown }
enum TransactionItemStatus { loading, succeeded, failed }

@freezed
class TransactionItemState with _$TransactionItemState {
  const factory TransactionItemState({
    @Default(TransactionType.unknown) TransactionType transactionType,
    @Default(TransactionItemStatus.loading)
        TransactionItemStatus transactionStatus,
    int? signedAmount,
  }) = _TransactionItemState;
}
