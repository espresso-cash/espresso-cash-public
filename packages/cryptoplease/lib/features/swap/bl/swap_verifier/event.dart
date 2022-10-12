part of 'bloc.dart';

@freezed
class SwapVerifierEvent with _$SwapVerifierEvent {
  const factory SwapVerifierEvent.swapRequested({
    required JupiterRoute jupiterRoute,
  }) = SwapRequested;

  const factory SwapVerifierEvent.retryRequested() = RetryRequested;
}
