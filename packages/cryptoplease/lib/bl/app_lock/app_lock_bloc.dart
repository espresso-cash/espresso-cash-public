import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_lock_bloc.freezed.dart';

part 'app_lock_event.dart';
part 'app_lock_state.dart';

typedef _Emitter = Emitter<AppLockState>;

class AppLockBloc extends Bloc<AppLockEvent, AppLockState> {
  AppLockBloc({
    required FlutterSecureStorage secureStorage,
  })  : _secureStorage = secureStorage,
        super(const AppLockState.none()) {
    on<AppLockEvent>(_eventHandler, transformer: sequential());
  }

  final FlutterSecureStorage _secureStorage;

  EventHandler<AppLockEvent, AppLockState> get _eventHandler =>
      (e, emit) => e.map(
            init: (e) => _onInit(e, emit),
            enable: (e) => _onEnable(e, emit),
            disable: (e) => _onDisable(e, emit),
            lock: (e) => _onLock(e, emit),
            unlock: (e) => _onUnlock(e, emit),
            logout: (e) => _onLogout(e, emit),
          );

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

  Future<void> _onLock(AppLockEventLock _, _Emitter emit) async {
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
