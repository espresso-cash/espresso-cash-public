import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_lock_bloc.freezed.dart';
part 'app_lock_event.dart';
part 'app_lock_state.dart';

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
      (e, emit) => e.map(
            init: (e) => _onInit(e, emit),
            enable: (e) => _onEnable(e, emit),
            disable: (e) => _onDisable(e, emit),
            lock: (e) => _onLock(e, emit),
            usePin: (e) => _onUsePin(e, emit),
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
    final localAuth = event.useLocalAuth
        ? const LocalAuthPreference.enabled()
        : const LocalAuthPreference.disabled();
    await _secureStorage.write(key: _key, value: event.pin);
    await _secureStorage.saveLocalAuthPreference(localAuth);
    emit(const AppLockState.enabled(disableFailed: false));
  }

  Future<void> _onDisable(AppLockEventDisable event, _Emitter emit) async {
    if (state is! AppLockStateEnabled) return;
    final pin = await _secureStorage.read(key: _key);
    if (pin == event.pin) {
      await _secureStorage.delete(key: _key);
      await _secureStorage.delete(key: _preferAuthPreferenceKey);
      emit(const AppLockState.disabled());
    } else {
      emit(const AppLockState.enabled(disableFailed: true));
    }
  }

  Future<void> _onUsePin(AppLockEventUsePin _, _Emitter emit) async {
    if (state is! AppLockStateLocked) return;
    emit(
      const AppLockState.locked(
        isRetrying: false,
        localAuth: LocalAuthPreference.disabled(),
      ),
    );
  }

  Future<void> _onLock(AppLockEventLock _, _Emitter emit) async {
    if (state is! AppLockStateEnabled) return;
    final localAuth = await _secureStorage.readLocalAuthPreference();

    emit(
      AppLockState.locked(
        isRetrying: false,
        localAuth: localAuth,
      ),
    );
  }

  Future<void> _onUnlock(AppLockEventUnlock event, _Emitter emit) async {
    if (state is! AppLockStateLocked) return;

    final unlocked = await event.mode.map(
      authPreference: (_) async => true,
      pin: (event) async {
        final pin = await _secureStorage.read(key: _key);

        return event.pin == pin;
      },
    );

    if (unlocked) {
      emit(const AppLockState.enabled(disableFailed: false));
    } else {
      emit(
        const AppLockState.locked(
          isRetrying: true,
          localAuth: LocalAuthPreference.disabled(),
        ),
      );
    }
  }
}

const _key = 'lock-key';
const _preferAuthPreferenceKey = 'biometric-lock-key';

extension on FlutterSecureStorage {
  Future<LocalAuthPreference> readLocalAuthPreference() async {
    final value = await read(key: _preferAuthPreferenceKey);
    switch (value) {
      case 'enabled':
        return const LocalAuthPreference.enabled();
      case 'disabled':
        return const LocalAuthPreference.disabled();
      default:
        return const LocalAuthPreference.neverAsked();
    }
  }

  Future<void> saveLocalAuthPreference(
      LocalAuthPreference authPreference) async {
    final value = authPreference.map(
      disabled: always('disabled'),
      enabled: always('enabled'),
      neverAsked: always('neverAsked'),
    );

    await write(key: _preferAuthPreferenceKey, value: value);
  }
}
