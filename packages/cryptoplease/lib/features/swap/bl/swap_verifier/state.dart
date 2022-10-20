part of 'bloc.dart';

@freezed
class SwapVerifierState with _$SwapVerifierState {
  const factory SwapVerifierState.idle() = Idle;

  const factory SwapVerifierState.preparing() = Preparing;

  const factory SwapVerifierState.settingUp(JupiterSwapTransactions tx) =
      SettingUp;

  const factory SwapVerifierState.swapping(JupiterSwapTransactions tx) =
      Swapping;

  const factory SwapVerifierState.cleaningUp(JupiterSwapTransactions tx) =
      CleaningUp;

  const factory SwapVerifierState.finished() = Finished;

  const factory SwapVerifierState.failed(SwapException error) = Failed;

  const SwapVerifierState._();
}

extension SwapVerifierExt on SwapVerifierState {
  bool get isProcessing => maybeMap(finished: F, failed: F, orElse: T);
}
