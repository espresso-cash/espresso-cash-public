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
        ? const LocalBiometrics.enabled()
        : const LocalBiometrics.disabled();
    await _secureStorage.write(key: _key, value: event.pin);
    await _secureStorage.saveLocalBiometrics(localAuth);
    emit(const AppLockState.enabled(disableFailed: false));
  }

  Future<void> _onDisable(AppLockEventDisable event, _Emitter emit) async {
    if (state is! AppLockStateEnabled) return;
    final pin = await _secureStorage.read(key: _key);
    if (pin == event.pin) {
      await _secureStorage.delete(key: _key);
      await _secureStorage.delete(key: _preferBiometricsKey);
      emit(const AppLockState.disabled());
    } else {
      emit(const AppLockState.enabled(disableFailed: true));
    }
  }

  Future<void> _onLock(AppLockEventLock _, _Emitter emit) async {
    if (state is! AppLockStateEnabled) return;
    emit(
      AppLockState.locked(
        isRetrying: false,
        localBiometrics: await _secureStorage.readLocalBiometrics(),
      ),
    );
  }

  Future<void> _onUnlock(AppLockEventUnlock event, _Emitter emit) async {
    if (state is! AppLockStateLocked) return;

    final unlocked = await event.mode.map(
      biometrics: (_) async => true,
      pin: (event) async {
        final pin = await _secureStorage.read(key: _key);

        return event.pin == pin;
      },
    );

    if (unlocked) {
      emit(const AppLockState.enabled(disableFailed: false));
    } else {
      emit(
        AppLockState.locked(
          isRetrying: true,
          localBiometrics: (state as AppLockStateLocked).localBiometrics,
        ),
      );
    }
  }
}

const _key = 'lock-key';
const _preferBiometricsKey = 'biometric-lock-key';

extension on FlutterSecureStorage {
  Future<LocalBiometrics> readLocalBiometrics() async {
    final value = await read(key: _preferBiometricsKey);
    switch (value) {
      case 'enabled':
        return const LocalBiometrics.enabled();
      case 'disabled':
        return const LocalBiometrics.disabled();
      default:
        return const LocalBiometrics.neverAsked();
    }
  }

  Future<void> saveLocalBiometrics(LocalBiometrics biometrics) async {
    final value = biometrics.map(
      disabled: always('disabled'),
      enabled: always('enabled'),
      neverAsked: always('neverAsked'),
    );

    await write(key: _preferBiometricsKey, value: value);
  }
}
