part of 'bloc.dart';

@freezed
class OutgoingTransfersEvent with _$OutgoingTransfersEvent {
  const factory OutgoingTransfersEvent.submitted(OutgoingTransferId id) =
      Submitted;
}
