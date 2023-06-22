import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../../core/file_manager.dart';
import '../../../core/wallet.dart';
import '../models/account.dart';
import '../models/ec_wallet.dart';
import '../models/mnemonic.dart';
import '../models/profile.dart';

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

  Future<void> _saveUserInfo({
    required String name,
    String? photo,
    String? country,
  }) async {
    await _storage.write(key: nameKey, value: name);
    if (photo != null) {
      await _storage.write(key: photoKey, value: basename(photo));
    }
    if (country != null) {
      await _storage.write(key: countryKey, value: country);
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
      final account = await _storage.loadAccount(_fileManager, _seedVault);
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

    await _storage.saveAccountSource(event.source);

    final profile = event.account.profile;

    await _saveUserInfo(
      name: profile.firstName,
      photo: profile.photoPath,
      country: profile.country,
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
    try {
      final authToken = await loadAuthToken(_storage);
      if (authToken != null) {
        await _seedVault.deauthorizeSeed(authToken);
      }
    } finally {
      await _storage.deleteAll();
      emit(const AccountsState());
    }
  }

  Future<void> _onProfileUpdated(
    ProfileUpdated event,
    Emitter<AccountsState> emit,
  ) async {
    final photo = await event.photo?.let(_fileManager.copyToAppDir);
    emit(state.copyWith(isProcessing: true));

    await _saveUserInfo(
      name: event.name,
      photo: photo?.path,
      country: event.country,
    );

    await _saveOnboardingState(hasFinishedOnboarding: true);

    emit(
      AccountsState(
        account: state.account?.copyWith(
          profile: Profile(
            firstName: event.name,
            photoPath: photo?.path,
            country: event.country,
          ),
        ),
        isProcessing: false,
        hasFinishedOnboarding: true,
      ),
    );
  }
}

Future<String> loadMnemonic(FlutterSecureStorage storage) =>
    storage.read(key: mnemonicKey).letAsync((it) => it ?? '');

Future<AuthToken?> loadAuthToken(FlutterSecureStorage storage) => storage
    .read(key: authTokenKey)
    .letAsync((it) => it.toString())
    .letAsync(AuthToken.tryParse);

extension on FlutterSecureStorage {
  Future<void> saveAccountSource(AccountSource source) => source.when(
        local: (it) => write(key: mnemonicKey, value: it.phrase),
        saga: (it) => write(key: authTokenKey, value: it.toString()),
      );

  /// Loads existing account if wallet data exists in [FlutterSecureStorage].
  Future<MyAccount?> loadAccount(
    FileManager manager,
    SeedVault seedVault,
  ) async {
    final mnemonic = await loadMnemonic(this);
    final authToken = await loadAuthToken(this);

    final ECWallet wallet;

    if (authToken != null) {
      wallet = await createSagaWallet(seedVault, authToken);
    } else if (mnemonic.isNotEmpty) {
      wallet = await createLocalWallet(mnemonic: mnemonic);
    } else {
      return null;
    }

    final photoPath = await read(key: photoKey);

    return MyAccount(
      profile: Profile(
        firstName: (await read(key: nameKey)) ?? '',
        photoPath: (await photoPath?.let(manager.loadFromAppDir))?.path,
        country: await read(key: countryKey),
      ),
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

@visibleForTesting
const countryKey = 'country';
