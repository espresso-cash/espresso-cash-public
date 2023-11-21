import 'package:injectable/injectable.dart';

import '../accounts/data/account_repository.dart';
import '../accounts/models/ec_wallet.dart';

const authScope = 'auth';

@module
abstract class AuthModule {
  const AuthModule();

  @Singleton(scope: authScope)
  Future<ECWallet> wallet(AccountRepository repository) async {
    final account = await repository.loadAccount();

    // ignore: avoid-non-null-assertion, shouldn't be null
    return account!.wallet;
  }
}
