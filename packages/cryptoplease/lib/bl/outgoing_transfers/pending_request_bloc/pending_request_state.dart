part of 'pending_request_bloc.dart';

@freezed
class PendingRequestState with _$PendingRequestState {
  const factory PendingRequestState(SolanaPayRequest? request) =
      _PendingRequestState;
}
