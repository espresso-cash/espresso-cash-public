import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../../core/wallet.dart';
import '../models/account.dart';
import '../models/ec_wallet.dart';
import '../models/mnemonic.dart';

part 'accounts_bloc.freezed.dart';
part 'accounts_event.dart';
part 'accounts_state.dart';

@injectable
class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required FlutterSecureStorage storage,
    required SeedVault seedVault,
  })  : _storage = storage,
        _seedVault = seedVault,
        super(const AccountsState(isProcessing: true)) {
    on<AccountsEvent>(_eventHandler, transformer: sequential());
  }

  final FlutterSecureStorage _storage;
  final SeedVault _seedVault;

  EventHandler<AccountsEvent, AccountsState> get _eventHandler =>
      (event, emit) => event.map(
            initialize: (_) => _onInitialize(emit),
            created: (event) => _onCreated(event, emit),
            loggedOut: (_) => _onLoggedOut(emit),
          );

  Future<void> _onInitialize(Emitter<AccountsState> emit) async {
    emit(state.copyWith(isProcessing: true));
    try {
      final account = await _storage.loadAccount(_seedVault);

      emit(state.copyWith(account: account, isProcessing: false));
    } on Exception {
      emit(state.copyWith(isProcessing: false));
    }
  }

  Future<void> _onCreated(Created event, Emitter<AccountsState> emit) async {
    emit(state.copyWith(isProcessing: true));

    await _storage.saveAccountSource(event.source);

    emit(state.copyWith(account: event.account, isProcessing: false));
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
  Future<MyAccount?> loadAccount(SeedVault seedVault) async {
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

    return MyAccount(
      accessMode: const AccessMode.loaded(),
      wallet: wallet,
    );
  }
}

@visibleForTesting
const authTokenKey = 'authToken';

@visibleForTesting
const mnemonicKey = 'mnemonic';
