import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_lock_bloc.freezed.dart';

@Freezed(when: FreezedWhenOptions.none, map: FreezedMapOptions.none)
sealed class AppLockEvent with _$AppLockEvent {
  const factory AppLockEvent.unlock(String pin) = AppLockEventUnlock;

  const factory AppLockEvent.lock() = AppLockEventLock;

  const factory AppLockEvent.enable(String pin) = AppLockEventEnable;

  const factory AppLockEvent.disable(String pin) = AppLockEventDisable;

  const factory AppLockEvent.init() = AppLockEventInit;

  const factory AppLockEvent.logout() = AppLockEventLogout;
}

@Freezed(when: FreezedWhenOptions.none, map: FreezedMapOptions.none)
sealed class AppLockState with _$AppLockState {
  const factory AppLockState.none() = AppLockStateNone;

  const factory AppLockState.enabled({
    required bool disableFailed,
  }) = AppLockStateEnabled;

  const factory AppLockState.locked({
    required bool isRetrying,
  }) = AppLockStateLocked;

  const factory AppLockState.disabled() = AppLockStateDisabled;
}

typedef _Emitter = Emitter<AppLockState>;

@injectable
class AppLockBloc extends Bloc<AppLockEvent, AppLockState> {
  AppLockBloc({
    required FlutterSecureStorage secureStorage,
  })  : _secureStorage = secureStorage,
        super(const AppLockState.none()) {
    on<AppLockEvent>(_eventHandler, transformer: sequential());
  }

  final FlutterSecureStorage _secureStorage;

  EventHandler<AppLockEvent, AppLockState> get _eventHandler =>
      (e, emit) => switch (e) {
            AppLockEventInit() => _onInit(e, emit),
            AppLockEventEnable() => _onEnable(e, emit),
            AppLockEventDisable() => _onDisable(e, emit),
            AppLockEventLock() => _onLock(e, emit),
            AppLockEventUnlock() => _onUnlock(e, emit),
            AppLockEventLogout() => _onLogout(e, emit),
          };

  Future<void> _onInit(AppLockEventInit _, _Emitter emit) async {
    final pin = await _secureStorage.read(key: _key);
    if (pin == null) {
      emit(const AppLockState.disabled());
    } else {
      emit(const AppLockState.enabled(disableFailed: false));
    }
  }

  Future<void> _onLogout(AppLockEventLogout _, _Emitter emit) async {
    await _secureStorage.delete(key: _key);
    emit(const AppLockState.disabled());
  }

  Future<void> _onEnable(AppLockEventEnable event, _Emitter emit) async {
    await _secureStorage.write(key: _key, value: event.pin);
    emit(const AppLockState.enabled(disableFailed: false));
  }

  Future<void> _onDisable(AppLockEventDisable event, _Emitter emit) async {
    if (state is! AppLockStateEnabled) return;
    final pin = await _secureStorage.read(key: _key);
    if (pin == event.pin) {
      await _secureStorage.delete(key: _key);
      emit(const AppLockState.disabled());
    } else {
      emit(const AppLockState.enabled(disableFailed: true));
    }
  }

  void _onLock(AppLockEventLock _, _Emitter emit) {
    if (state is! AppLockStateEnabled) return;
    emit(const AppLockState.locked(isRetrying: false));
  }

  Future<void> _onUnlock(AppLockEventUnlock event, _Emitter emit) async {
    if (state is! AppLockStateLocked) return;
    final pin = await _secureStorage.read(key: _key);
    if (pin == event.pin) {
      emit(const AppLockState.enabled(disableFailed: false));
    } else {
      emit(const AppLockState.locked(isRetrying: true));
    }
  }
}

const _key = 'lock-key';
