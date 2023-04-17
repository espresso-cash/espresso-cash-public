part of 'bloc.dart';

@freezed
class RemoteRequestEvent with _$RemoteRequestEvent {
  const factory RemoteRequestEvent.declined() = _Decline;
  const factory RemoteRequestEvent.accepted() = _Accepted;
}
