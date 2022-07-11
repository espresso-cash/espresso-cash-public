part of 'pending_request_bloc.dart';

@freezed
class PendingRequestEvent with _$PendingRequestEvent {
  const factory PendingRequestEvent.linkAdded(Uri link) =
      PendingRequestLinkAdded;

  const factory PendingRequestEvent.consumed() = PendingRequestConsumed;
}
