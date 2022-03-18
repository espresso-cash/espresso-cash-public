part of 'transaction_details_bloc.dart';

@freezed
class TransactionDetailsEvent with _$TransactionDetailsEvent {
  const factory TransactionDetailsEvent.load({
    required String transactionHash,
  }) = LoadTransactionDetails;
}
