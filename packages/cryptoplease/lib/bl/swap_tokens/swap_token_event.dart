part of 'swap_token_bloc.dart';

@freezed
class SwapTokenEvent with _$SwapTokenEvent {
  const factory SwapTokenEvent.load() = SwapTokenLoadEvent;
}
