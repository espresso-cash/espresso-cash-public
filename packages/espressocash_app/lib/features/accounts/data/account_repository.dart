import 'package:dfunc/dfunc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../models/account.dart';
import '../models/ec_wallet.dart';
import '../models/mnemonic.dart';
import '../models/wallet.dart';

@injectable
class AccountRepository {
  const AccountRepository(this._storage);

  final FlutterSecureStorage _storage;

  Future<String> loadMnemonic() =>
      _storage.read(key: mnemonicKey).letAsync((it) => it ?? '');

  Future<void> saveAccountSource(AccountSource source) => source.when(
        local: (it) => _storage.write(key: mnemonicKey, value: it.phrase),
      );

  /// Loads existing account if wallet data exists in [FlutterSecureStorage].
  Future<MyAccount?> loadAccount() async {
    final mnemonic = await loadMnemonic();

    final ECWallet wallet;

    if (mnemonic.isNotEmpty) {
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
