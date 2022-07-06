part of 'transactions_bloc.dart';

@freezed
class TransactionsEvent with _$TransactionsEvent {
  const TransactionsEvent._();

  const factory TransactionsEvent.loadRequested() = LoadRequested;
}
