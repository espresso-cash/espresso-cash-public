part of 'app_lock_bloc.dart';

@freezed
class AppLockState with _$AppLockState {
  const factory AppLockState.none() = AppLockStateNone;

  const factory AppLockState.enabled({
    required bool disableFailed,
    required LocalAuthPreference localAuth,
  }) = AppLockStateEnabled;

  const factory AppLockState.locked({
    required bool isRetrying,
    required LocalAuthPreference localAuth,
  }) = AppLockStateLocked;

  const factory AppLockState.disabled() = AppLockStateDisabled;
}

extension AppLockExt on AppLockState {
  bool get shouldAskForBiometrics => maybeMap(
        enabled: (it) =>
            it.localAuth.maybeMap(orElse: F, enabled: T) && !it.disableFailed,
        locked: (it) =>
            it.localAuth.maybeMap(orElse: F, enabled: T) && !it.isRetrying,
        orElse: F,
      );
}

@freezed
class LocalAuthPreference with _$LocalAuthPreference {
  const factory LocalAuthPreference.disabled() = _Disabled;
  const factory LocalAuthPreference.enabled() = _Enabled;
  const factory LocalAuthPreference.neverAsked() = _NeverAsked;
}
