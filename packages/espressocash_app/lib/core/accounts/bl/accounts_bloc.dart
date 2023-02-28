import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../file_manager.dart';
import '../../wallet.dart';
import 'account.dart';
import 'ec_wallet.dart';
import 'mnemonic.dart';

part 'accounts_bloc.freezed.dart';
part 'accounts_event.dart';
part 'accounts_state.dart';

@injectable
class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required FlutterSecureStorage storage,
    required FileManager fileManager,
    required SeedVault seedVault,
  })  : _storage = storage,
        _fileManager = fileManager,
        _seedVault = seedVault,
        super(const AccountsState(isProcessing: true)) {
    on<AccountsEvent>(_eventHandler, transformer: sequential());
  }

  final FlutterSecureStorage _storage;
  final FileManager _fileManager;
  final SeedVault _seedVault;

  EventHandler<AccountsEvent, AccountsState> get _eventHandler =>
      (event, emit) => event.map(
            initialize: (_) => _onInitialize(emit),
            created: (event) => _onCreated(event, emit),
            profileUpdated: (event) => _onProfileUpdated(event, emit),
            loggedOut: (_) => _onLoggedOut(emit),
          );

  Future<void> _saveNameAndPhoto({required String name, String? photo}) async {
    await _storage.write(key: nameKey, value: name);
    if (photo != null) {
      await _storage.write(key: photoKey, value: basename(photo));
    }
  }

  Future<void> _saveOnboardingState({
    required bool hasFinishedOnboarding,
  }) async {
    await _storage.write(
      key: onboardingKey,
      value: hasFinishedOnboarding.toString(),
    );
  }

  Future<bool> _loadOnboardingState() async {
    final hasFinishedOnboarding = await _storage.read(key: onboardingKey);

    return hasFinishedOnboarding == 'true';
  }

  Future<void> _onInitialize(Emitter<AccountsState> emit) async {
    emit(state.copyWith(isProcessing: true));
    try {
      final authToken = await _storage
          .read(key: authTokenKey)
          .letAsync((it) => it.toString())
          .letAsync(AuthToken.tryParse);

      final ECWallet? wallet;

      if (authToken != null) {
        wallet = await restoreSagaWallet(authToken, _seedVault);
      } else {
        final mnemonic = await loadMnemonic(_storage);
        if (mnemonic.isNotEmpty) {
          wallet = await createLocalWallet(
            mnemonic: mnemonic,
            account: 0,
          );
        } else {
          wallet = null;
        }
      }

      final account = await wallet.maybeFlatMap(
        (it) async => _fileManager.loadAccount(_storage, it),
      );
      final hasFinishedOnboarding = await _loadOnboardingState();

      emit(
        state.copyWith(
          account: account,
          isProcessing: false,
          hasFinishedOnboarding: hasFinishedOnboarding,
        ),
      );
    } on Exception {
      emit(state.copyWith(isProcessing: false));
    }
  }

  Future<void> _onCreated(Created event, Emitter<AccountsState> emit) async {
    emit(state.copyWith(isProcessing: true));
    final wallet = event.account.wallet;

    if (wallet is SagaWallet) {
      await _storage.write(key: authTokenKey, value: wallet.token.toString());
    } else {
      await _storage.write(key: mnemonicKey, value: event.mnemonic.phrase);
    }

    await _saveNameAndPhoto(
      name: event.account.firstName,
      photo: event.account.photoPath,
    );

    await _saveOnboardingState(
      hasFinishedOnboarding: event.hasFinishedOnboarding,
    );

    emit(
      state.copyWith(
        account: event.account,
        isProcessing: false,
        hasFinishedOnboarding: event.hasFinishedOnboarding,
      ),
    );
  }

  Future<void> _onLoggedOut(Emitter<AccountsState> emit) async {
    await _storage.deleteAll();
    emit(const AccountsState());
  }

  Future<void> _onProfileUpdated(
    ProfileUpdated event,
    Emitter<AccountsState> emit,
  ) async {
    final photo = await event.photo?.let(_fileManager.copyToAppDir);
    emit(state.copyWith(isProcessing: true));

    await _saveNameAndPhoto(name: event.name, photo: photo?.path);

    await _saveOnboardingState(hasFinishedOnboarding: true);

    emit(
      AccountsState(
        account: state.account?.copyWith(
          firstName: event.name,
          photoPath: photo?.path,
        ),
        isProcessing: false,
        hasFinishedOnboarding: true,
      ),
    );
  }
}

Future<String> loadMnemonic(FlutterSecureStorage storage) =>
    storage.read(key: mnemonicKey).then((value) => value ?? '');

extension on FileManager {
  /// Loads existing account if wallet data exist in [storage].
  Future<MyAccount?> loadAccount(
    FlutterSecureStorage storage,
    ECWallet wallet,
  ) async {
    final photoPath = await storage.read(key: photoKey);

    return MyAccount(
      firstName: (await storage.read(key: nameKey)) ?? '',
      photoPath: (await photoPath?.let(loadFromAppDir))?.path,
      accessMode: const AccessMode.loaded(),
      wallet: wallet,
    );
  }
}

@visibleForTesting
const authTokenKey = 'authToken';

@visibleForTesting
const mnemonicKey = 'mnemonic';

@visibleForTesting
const nameKey = 'name';

@visibleForTesting
const photoKey = 'photo';

@visibleForTesting
const onboardingKey = 'onboarding';
