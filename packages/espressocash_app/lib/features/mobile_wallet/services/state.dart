part of 'bloc.dart';

@freezed
class RemoteRequestState with _$RemoteRequestState {
  const factory RemoteRequestState.requested(RemoteRequest request) =
      _Requested;

  const factory RemoteRequestState.loading() = _Loading;

  const factory RemoteRequestState.result(Object? result) = _Result;
}
