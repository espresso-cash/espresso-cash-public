part of 'bloc.dart';

@freezed
class NftCreateOutgoingTransferEvent with _$NftCreateOutgoingTransferEvent {
  const factory NftCreateOutgoingTransferEvent.typeUpdated(
    OutgoingTransferType transferType,
  ) = TypeUpdated;

  const factory NftCreateOutgoingTransferEvent.recipientUpdated(
    String address,
  ) = RecipientUpdated;

  const factory NftCreateOutgoingTransferEvent.referenceUpdated(
    String reference,
  ) = ReferenceUpdated;

  const factory NftCreateOutgoingTransferEvent.memoUpdated(String memo) =
      MemoUpdated;

  const factory NftCreateOutgoingTransferEvent.cleared() = Cleared;

  const factory NftCreateOutgoingTransferEvent.submitted() = Submitted;
}
