part of 'bloc.dart';

@freezed
class OutgoingTransferStatusEvent with _$OutgoingTransferStatusEvent {
  const factory OutgoingTransferStatusEvent.load() = LoadOutgoingTransferStatus;
  const factory OutgoingTransferStatusEvent.cancelTransfer() =
      CancelOutgoingTransferStatus;
}
