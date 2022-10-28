part of 'app_lock_bloc.dart';

@freezed
class AppLockState with _$AppLockState {
  const factory AppLockState.none() = AppLockStateNone;

  const factory AppLockState.enabled({
    required bool disableFailed,
  }) = AppLockStateEnabled;

  const factory AppLockState.locked({
    required bool isRetrying,
  }) = AppLockStateLocked;

  const factory AppLockState.disabled() = AppLockStateDisabled;
}
