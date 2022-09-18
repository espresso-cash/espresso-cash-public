part of 'bloc.dart';

@freezed
class OutgoingTransferStatusEvent with _$OutgoingTransferStatusEvent {
  const factory OutgoingTransferStatusEvent.init() = InitOutgoingTransferStatus;
  const factory OutgoingTransferStatusEvent.updated() =
      UpdateOutgoingTransferStatus;
  const factory OutgoingTransferStatusEvent.cancelled() =
      CancelOutgoingTransferStatus;
}
