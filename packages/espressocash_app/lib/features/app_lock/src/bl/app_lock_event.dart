part of 'app_lock_bloc.dart';

@freezed
class AppLockEvent with _$AppLockEvent {
  const factory AppLockEvent.unlock(AppUnlockMode mode) = AppLockEventUnlock;

  const factory AppLockEvent.lock() = AppLockEventLock;

  const factory AppLockEvent.enable(String pin, bool useLocalAuth) =
      AppLockEventEnable;

  const factory AppLockEvent.disable(AppUnlockMode mode) = AppLockEventDisable;

  const factory AppLockEvent.usePin() = AppLockEventUsePin;

  const factory AppLockEvent.init() = AppLockEventInit;

  const factory AppLockEvent.logout() = AppLockEventLogout;
}

@freezed
class AppUnlockMode with _$AppUnlockMode {
  const factory AppUnlockMode.pin(String pin) = AppUnlockPinMode;

  const factory AppUnlockMode.biometrics() = AppUnlockBiometricsMode;
}
