part of 'app_lock_bloc.dart';


@freezed
class AppLockState with _$AppLockState {
  const factory AppLockState.none() = AppLockStateNone;

  const factory AppLockState.enabled({
    required bool disableFailed,
  }) = AppLockStateEnabled;

  const factory AppLockState.locked({
    required LocalBiometrics localBiometrics,
    required bool isRetrying,
  }) = AppLockStateLocked;

  const factory AppLockState.disabled() = AppLockStateDisabled;
}

@freezed
class LocalBiometrics with _$LocalBiometrics{
  const factory LocalBiometrics.disabled() = _Disabled;
  const factory LocalBiometrics.enabled() = _Enabled;
  const factory LocalBiometrics.neverAsked() = _NeverAsked;
}
