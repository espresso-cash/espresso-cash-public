part of 'transaction_item_bloc.dart';

@freezed
class TransactionItemEvent with _$TransactionItemEvent {
  const factory TransactionItemEvent.initialized({
    required Transaction transaction,
    required Token token,
  }) = TransactionItemInitializedEvent;
}
