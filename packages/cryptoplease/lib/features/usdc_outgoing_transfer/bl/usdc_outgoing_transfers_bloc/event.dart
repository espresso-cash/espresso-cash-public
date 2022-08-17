part of 'bloc.dart';

@freezed
class UsdcOutgoingTransfersEvent with _$UsdcOutgoingTransfersEvent {
  const factory UsdcOutgoingTransfersEvent.submitted(OutgoingTransferId id) =
      Submitted;
}
