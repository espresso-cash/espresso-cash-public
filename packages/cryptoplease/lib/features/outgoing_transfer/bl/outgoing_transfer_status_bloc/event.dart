part of 'bloc.dart';

@freezed
class OutgoingTransferStatusEvent with _$OutgoingTransferStatusEvent {
  const factory OutgoingTransferStatusEvent.loaded() =
      LoadOutgoingTransferStatus;
  const factory OutgoingTransferStatusEvent.cancelled() =
      CancelOutgoingTransferStatus;
}
