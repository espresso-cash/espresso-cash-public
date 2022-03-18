part of 'bloc.dart';

@freezed
class CreateOutgoingTransferEvent with _$CreateOutgoingTransferEvent {
  const factory CreateOutgoingTransferEvent.typeUpdated(
    OutgoingTransferType transferType,
  ) = TypeUpdated;

  const factory CreateOutgoingTransferEvent.tokenAmountUpdated(Decimal amount) =
      TokenAmountUpdated;

  const factory CreateOutgoingTransferEvent.fiatAmountUpdated(Decimal amount) =
      FiatAmountUpdated;

  const factory CreateOutgoingTransferEvent.tokenUpdated(
    Token token, {

    /// If true, it will be the only available token.
    @Default(false) bool lock,
  }) = TokenUpdated;

  const factory CreateOutgoingTransferEvent.recipientUpdated(String address) =
      RecipientUpdated;

  const factory CreateOutgoingTransferEvent.referenceUpdated(String reference) =
      ReferenceUpdated;

  const factory CreateOutgoingTransferEvent.memoUpdated(String memo) =
      MemoUpdated;

  const factory CreateOutgoingTransferEvent.maxRequested() = MaxRequested;

  const factory CreateOutgoingTransferEvent.cleared() = Cleared;

  const factory CreateOutgoingTransferEvent.submitted() = Submitted;
}
