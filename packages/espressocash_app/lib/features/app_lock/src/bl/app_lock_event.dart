part of 'app_lock_bloc.dart';

@freezed
class AppLockEvent with _$AppLockEvent {
  const factory AppLockEvent.unlock(String pin) = AppLockEventUnlock;

  const factory AppLockEvent.lock() = AppLockEventLock;

  const factory AppLockEvent.enable(String pin) = AppLockEventEnable;

  const factory AppLockEvent.disable(String pin) = AppLockEventDisable;

  const factory AppLockEvent.init() = AppLockEventInit;

  const factory AppLockEvent.logout() = AppLockEventLogout;
}
