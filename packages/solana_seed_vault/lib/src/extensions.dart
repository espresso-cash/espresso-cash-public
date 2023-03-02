import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:solana_seed_vault/src/models/account.dart';
import 'package:solana_seed_vault/src/models/auth_token.dart';
import 'package:solana_seed_vault/src/models/filter.dart';
import 'package:solana_seed_vault/src/models/implementation_limits.dart';
import 'package:solana_seed_vault/src/models/seed.dart';
import 'package:solana_seed_vault/src/seed_vault.dart';
import 'package:solana_seed_vault/src/wallet_contract_v1.dart';

extension SeedVaultHelperExt on SeedVault {
  Future<List<Seed>> getParsedAuthorizedSeeds({
    AccountFilter accountFilter = const AccountFilter(),
  }) async {
    final result = await getAuthorizedSeeds();

    return result
        .map((it) => it.cursorToSeed(this, accountFilter))
        .let(Future.wait);
  }

  Future<Seed> getParsedAuthorizedSeed(
    AuthToken authToken, {
    AccountFilter accountFilter = const AccountFilter(),
  }) =>
      getAuthorizedSeed(authToken: authToken)
          .letAsync((it) => it.cursorToSeed(this, accountFilter));

  Future<List<Account>> getParsedAccounts(
    AuthToken authToken, {
    AccountFilter filter = const AccountFilter(),
  }) =>
      getAccounts(
        authToken: authToken,
        filterOnColumn: filter.toColumn(),
        value: filter.toValue(),
      ).letAsync((it) => it.map((it) => it.cursorToAccount()).toList());

  Future<Account> getParsedAccount({
    required AuthToken authToken,
    required int accountId,
  }) =>
      getAccount(authToken: authToken, id: accountId)
          .letAsync((it) => it.cursorToAccount());

  Future<ImplementationLimits> getParsedImplementationLimitsForPurpose(
    Purpose purpose,
  ) =>
      getImplementationLimitsForPurpose(purpose)
          .letAsync((it) => it.cursorToImplementationLimits());
}

extension CursorToModelExt on CursorData {
  Future<Seed> cursorToSeed(SeedVault seedVault, AccountFilter filter) async {
    final authToken = this[WalletContractV1.authorizedSeedsAuthToken] as int;
    final name = this[WalletContractV1.authorizedSeedsSeedName] as String;
    final purpose = this[WalletContractV1.authorizedSeedsAuthPurpose] as int;
    final accounts = await seedVault.getParsedAccounts(
      authToken,
      filter: filter,
    );

    return Seed(
      authToken: authToken,
      name: name,
      purpose: Purpose.values.elementAt(purpose),
      accounts: accounts,
    );
  }

  Account cursorToAccount() => Account(
        id: this[WalletContractV1.accountsAccountId] as int,
        name: this[WalletContractV1.accountsAccountName] as String,
        derivationPath:
            (this[WalletContractV1.accountsBip32DerivationPath] as String)
                .let(Uri.parse),
        publicKeyEncoded:
            this[WalletContractV1.accountsPublicKeyEncoded] as String,
        publicKeyRaw: this[WalletContractV1.accountsPublicKeyRaw] as Uint8List,
        isUserWallet: this[WalletContractV1.accountsAccountIsUserWallet] == 1,
        isValid: this[WalletContractV1.accountsAccountIsValid] == 1,
      );

  ImplementationLimits cursorToImplementationLimits() => ImplementationLimits(
        maxBip32PathDepth: WalletContractV1.bip32UriMaxDepth,
        maxSigningRequests:
            this[WalletContractV1.implementationLimitsMaxSigningRequests]
                as int,
        maxRequestedSignatures:
            this[WalletContractV1.implementationLimitsMaxRequestedSignatures]
                as int,
        maxRequestedPublicKeys:
            this[WalletContractV1.implementationLimitsMaxRequestedPublicKeys]
                as int,
      );
}

extension on AccountFilter {
  String? toColumn() => when(
        () => null,
        byId: always(WalletContractV1.accountsAccountId),
        byName: always(WalletContractV1.accountsAccountName),
        byDerivationPath: always(WalletContractV1.accountsBip32DerivationPath),
        byPublicKeyEncoded: always(WalletContractV1.accountsPublicKeyEncoded),
        byIsUserWallet: always(WalletContractV1.accountsAccountIsUserWallet),
        byIsValid: always(WalletContractV1.accountsAccountIsValid),
      );

  Object? toValue() => when(
        () => null,
        byId: identity,
        byName: identity,
        byDerivationPath: (it) => it.toString(),
        byPublicKeyEncoded: identity,
        byIsUserWallet: (it) => it ? '1' : '0',
        byIsValid: (it) => it ? '1' : '0',
      );
}
