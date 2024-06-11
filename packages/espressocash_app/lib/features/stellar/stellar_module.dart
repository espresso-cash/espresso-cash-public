import 'package:injectable/injectable.dart';

import '../accounts/auth_scope.dart';
import '../accounts/data/account_repository.dart';
import 'constants.dart';
import 'models/stellar_wallet.dart';
import 'service/stellar_client.dart';

@module
abstract class StellarModule {
  const StellarModule();

  @Singleton(scope: authScope)
  @preResolve
  Future<StellarWallet> wallet(AccountRepository repository) async {
    final mnemonic = await repository.loadMnemonic();

    return createStellarWallet(mnemonic: mnemonic);
  }

  @LazySingleton(scope: authScope)
  StellarClient stellarClient() => StellarClient(stellarSdk);
}
