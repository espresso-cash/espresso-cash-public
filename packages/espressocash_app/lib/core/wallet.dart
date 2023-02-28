import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:solana/solana.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import 'accounts/bl/ec_wallet.dart';

Future<LocalWallet> createLocalWallet({
  required String mnemonic,
  required int account,
}) async {
  final wallet =
      await compute(_createKeyPair, KeyPairParams(mnemonic, account));

  return LocalWallet(wallet);
}

Future<SagaWallet> createSagaWallet(SeedVault seedVault) async {
  final authToken = await seedVault.createSeed(Purpose.signSolanaTransaction);
  final account = await seedVault
      .getParsedAccounts(authToken)
      .letAsync((it) => it.findValidAccount());
  await seedVault.updateAccountIsUserWallet(
    authToken: authToken,
    accountId: account.id,
    isUserWallet: true,
  );
  await seedVault.updateAccountIsValid(
    authToken: authToken,
    accountId: account.id,
    isValid: true,
  );

  return SagaWallet(account, authToken);
}

Future<SagaWallet> restoreSagaWallet(
  AuthToken authToken,
  SeedVault seedVault,
) async {
  final account = await seedVault
      .getParsedAuthorizedSeed(authToken)
      .letAsync((it) => it.accounts.findValidAccount());

  return SagaWallet(account, authToken);
}

extension on List<Account> {
  Account findValidAccount() => first;
}

Future<Ed25519HDKeyPair> _createKeyPair(KeyPairParams params) =>
    Ed25519HDKeyPair.fromMnemonic(
      params.mnemonic,
      change: params.account,
    );

@immutable
class KeyPairParams {
  const KeyPairParams(this.mnemonic, this.account);

  final String mnemonic;
  final int account;
}
