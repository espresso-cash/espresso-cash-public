part of 'bloc.dart';

@freezed
sealed class RemoteRequestEvent with _$RemoteRequestEvent {
  const factory RemoteRequestEvent.declined() = _Decline;
  const factory RemoteRequestEvent.accepted() = _Accepted;
}
