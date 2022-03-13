part of 'bloc.dart';

@freezed
class FtCreateOutgoingTransferEvent with _$FtCreateOutgoingTransferEvent {
  const factory FtCreateOutgoingTransferEvent.typeUpdated(
    OutgoingTransferType transferType,
  ) = TypeUpdated;

  const factory FtCreateOutgoingTransferEvent.tokenAmountUpdated(
    Decimal amount,
  ) = TokenAmountUpdated;

  const factory FtCreateOutgoingTransferEvent.fiatAmountUpdated(
    Decimal amount,
  ) = FiatAmountUpdated;

  const factory FtCreateOutgoingTransferEvent.tokenUpdated(
    Token token, {

    /// If true, it will be the only available token.
    @Default(false) bool lock,
  }) = TokenUpdated;

  const factory FtCreateOutgoingTransferEvent.recipientUpdated(String address) =
      RecipientUpdated;

  const factory FtCreateOutgoingTransferEvent.referenceUpdated(
    String reference,
  ) = ReferenceUpdated;

  const factory FtCreateOutgoingTransferEvent.memoUpdated(String memo) =
      MemoUpdated;

  const factory FtCreateOutgoingTransferEvent.maxRequested() = MaxRequested;

  const factory FtCreateOutgoingTransferEvent.cleared() = Cleared;

  const factory FtCreateOutgoingTransferEvent.submitted() = Submitted;
}
