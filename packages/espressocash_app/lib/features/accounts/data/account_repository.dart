import 'package:dfunc/dfunc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../../core/wallet.dart';
import '../models/account.dart';
import '../models/ec_wallet.dart';
import '../models/mnemonic.dart';

@injectable
class AccountRepository {
  const AccountRepository(this._storage);

  final FlutterSecureStorage _storage;

  Future<String> loadMnemonic() =>
      _storage.read(key: mnemonicKey).letAsync((it) => it ?? '');

  Future<AuthToken?> loadAuthToken() => _storage
      .read(key: authTokenKey)
      .letAsync((it) => it.toString())
      .letAsync(AuthToken.tryParse);

  Future<void> saveAccountSource(AccountSource source) => source.when(
        local: (it) => _storage.write(key: mnemonicKey, value: it.phrase),
        saga: (it) => _storage.write(key: authTokenKey, value: it.toString()),
      );

  /// Loads existing account if wallet data exists in [FlutterSecureStorage].
  Future<MyAccount?> loadAccount(SeedVault seedVault) async {
    final mnemonic = await loadMnemonic();
    final authToken = await loadAuthToken();

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
