import 'package:injectable/injectable.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

import '../accounts/auth_scope.dart';
import '../accounts/data/account_repository.dart';
import 'constants.dart';
import 'models/stellar_wallet.dart';

@module
abstract class StellarModule {
  const StellarModule();

  @Singleton(scope: authScope)
  @preResolve
  Future<StellarWallet> wallet(AccountRepository repository) async {
    final mnemonic = await repository.loadMnemonic();

    return createStellarWallet(mnemonic: mnemonic);
  }

  @lazySingleton
  StellarSDK sdk() => stellarSdk;

  @lazySingleton
  SorobanServer client() => SorobanServer(sorobanRpcUrl);
}
