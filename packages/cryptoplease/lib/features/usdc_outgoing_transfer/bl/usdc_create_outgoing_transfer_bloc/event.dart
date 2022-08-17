part of 'bloc.dart';

@freezed
class UsdcCreateOutgoingTransferEvent with _$UsdcCreateOutgoingTransferEvent {
  const factory UsdcCreateOutgoingTransferEvent.tokenAmountUpdated(
    Decimal amount,
  ) = TokenAmountUpdated;

  const factory UsdcCreateOutgoingTransferEvent.cleared() = Cleared;

  const factory UsdcCreateOutgoingTransferEvent.submitted() = Submitted;
}
