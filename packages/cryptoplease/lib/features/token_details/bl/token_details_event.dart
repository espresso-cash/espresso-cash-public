part of 'token_details_bloc.dart';

@freezed
class TokenDetailEvent with _$TokenDetailEvent {
  const factory TokenDetailEvent.infoRequested() = FetchDetailsRequested;
}
