import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

part 'bloc.freezed.dart';

@freezed
class SeedVaultState with _$SeedVaultState {
  const factory SeedVaultState.none() = _None;

  const factory SeedVaultState.error(String err) = _Error;

  const factory SeedVaultState.unauthorized() = _Unauthorized;

  const factory SeedVaultState.loaded({
    required List<Seed> seeds,
    required ImplementationLimits limits,
    required bool hasUnauthorizedSeeds,
    required Uri? firstRequestedPublicKey,
    required Uri? lastRequestedPublicKey,
  }) = _Loaded;
}

class SeedVaultBloc extends Cubit<SeedVaultState> {
  SeedVaultBloc() : super(const SeedVaultState.none());

  late StreamSubscription<SeedVaultNotification> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }

  Future<void> init() async {
    final isInstalled = await SeedVault.instance.isAvailable(true);

    if (!isInstalled) {
      return emit(const SeedVaultState.error('Seed vault not installed'));
    }

    final granted = await SeedVault.instance.checkPermission();

    if (granted) {
      _subscription = Wallet.instance.changeStream.listen((_) => _refreshAll());

      return _refreshAll();
    } else {
      return emit(const SeedVaultState.unauthorized());
    }
  }

  Future<void> _refreshAll() async {
    const purpose = Purpose.signSolanaTransaction;
    final limits =
        await Wallet.instance.getImplementationLimitsForPurpose(purpose);
    final firstRequestedPublicKey =
        await _getRequestedPublicKeyByIndex(_firstRequestedPublicKeyIndex);
    final lastRequestedPublicKey = await _getRequestedPublicKeyByIndex(
      _firstRequestedPublicKeyIndex + limits.maxRequestedPublicKeys - 1,
    );

    emit(
      SeedVaultState.loaded(
        seeds: await Wallet.instance.getAuthorizedSeeds(),
        limits: limits,
        firstRequestedPublicKey: firstRequestedPublicKey,
        lastRequestedPublicKey: lastRequestedPublicKey,
        hasUnauthorizedSeeds:
            await Wallet.instance.hasUnauthorizedSeedsForPurpose(purpose),
      ),
    );
  }

  Future<void> signMessage(Seed seed, int messageCount) async {
    final signingRequests = List.generate(
      messageCount,
      (_) => SigningRequest(
        payload: Uint8List(_messageSize),
        requestedSignatures: [seed.accounts.first.derivationPath],
      ),
    );

    await Wallet.instance.signMessages(
      authToken: seed.authToken,
      signingRequests: signingRequests,
    );
  }

  Future<List<PublicKeyResponse>> requestPublicKey(Seed seed) async =>
      Wallet.instance.requestPublicKeys(
        authToken: seed.authToken,
        derivationPaths: seed.accounts.map((a) => a.derivationPath).toList(),
      );

  Future<void> deathorizeSeed(Seed seed) async {
    await Wallet.instance.deauthorizeSeed(seed.authToken);
  }

  Future<bool> authorizeSeed() async {
    final authToken =
        await Wallet.instance.authorizeSeed(Purpose.signSolanaTransaction);

    await authToken.whenOrNull(success: _onNewSeed);

    return authToken.map(success: T, failure: F);
  }

  Future<bool> importSeed() async {
    final authToken =
        await Wallet.instance.importSeed(Purpose.signSolanaTransaction);

    await authToken.whenOrNull(success: _onNewSeed);

    return authToken.map(success: T, failure: F);
  }

  Future<bool> createSeed() async {
    final authToken =
        await Wallet.instance.createSeed(Purpose.signSolanaTransaction);

    await authToken.whenOrNull(success: _onNewSeed);

    return authToken.map(success: T, failure: F);
  }

  // Mark two accounts as user wallets. This simulates a real wallet app
  // exploring each account and marking them as containing user funds.
  Future<void> _onNewSeed(AuthToken authToken) async {
    for (var i = 0; i < _accountsPerSeed; i++) {
      final derivationPath = await Bip44DerivationPath.instance.toUri(
        Bip44Data(account: BipLevel(index: i, hardened: true)),
      );
      final resolvedPath = await Wallet.instance.resolveDerivationPath(
        derivationPath: derivationPath,
        purpose: Purpose.signSolanaTransaction,
      );
      final account = await Wallet.instance
          .getAccounts(
            authToken,
            filter: AccountFilter.byDerivationPath(resolvedPath),
          )
          .letAsync((it) => it.singleOrNull);

      if (account == null) return;

      if (!account.isUserWallet) {
        await Wallet.instance.updateAccountIsUserWallet(
          authToken: authToken,
          accountId: account.id,
          isUserWallet: true,
        );
      }
    }
  }
}

Future<Uri> _getRequestedPublicKeyByIndex(int index) =>
    Bip32DerivationPath.instance.toUri(
      Bip32Data(levels: [BipLevel(index: index, hardened: true)]),
    );

const _firstRequestedPublicKeyIndex = 1000;
const _messageSize = 512;
const _accountsPerSeed = 2;
