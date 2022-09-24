part of 'token_info_bloc.dart';

@freezed
class TokenInfoEvent with _$TokenInfoEvent {
  const factory TokenInfoEvent.fetchRequested({
    required Token token,
  }) = FetchRequested;
}
