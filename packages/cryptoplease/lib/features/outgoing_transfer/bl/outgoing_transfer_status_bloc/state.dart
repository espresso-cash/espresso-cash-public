part of 'bloc.dart';

@freezed
class OutgoingTransferStatusState with _$OutgoingTransferStatusState {
  const factory OutgoingTransferStatusState.ongoing({
    @Default(ProcessingStateNone()) ProcessingState processingState,
  }) = OutgoingTransferOngoing;

  const factory OutgoingTransferStatusState.success({
    DateTime? executedDate,
  }) = OutgoingTransferSuccess;

  const factory OutgoingTransferStatusState.cancelled({
    DateTime? executedDate,
  }) = OutgoingTransferCancelled;
}

OutgoingTransferStatusState toState(OutgoingTransferStatus status) {
  switch (status.status) {
    case OutgoingStatus.success:
      return OutgoingTransferSuccess(executedDate: status.created);
    case OutgoingStatus.canceled:
      return OutgoingTransferCancelled(executedDate: status.created);
  }
}

@freezed
class Transaction with _$Transaction {
  const factory Transaction.generic({
    required Meta? meta,
    required DateTime? blockTime,
    required String hash,
  }) = GenericTransaction;

  const factory Transaction.transfer({
    required String hash,
    required String senderAddress,
    required String recipientAddress,
    required int amount,
    required DateTime? blockTime,
    Meta? meta,
  }) = TransferTransaction;
}
