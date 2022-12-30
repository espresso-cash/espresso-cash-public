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
      _subscription = Wallet.instance.changeStream.listen((_) => refreshUI());

      return refreshUI();
    } else {
      return emit(const SeedVaultState.unauthorized());
    }
  }

  Future<void> refreshUI() async {
    const purpose = Purpose.signSolanaTransaction;
    final limits =
        await Wallet.instance.getImplementationLimitsForPurpose(purpose);
    final firstRequestedPublicKey =
        await _getRequestedPublicKeyByIndex(_firstRequestedPublicKeyIndex);
    final lastRequestedPublicKey = await _getRequestedPublicKeyByIndex(
      _firstRequestedPublicKeyIndex + limits.maxRequestedPublicKeys - 1,
    );
    final seeds = await Wallet.instance.getAuthorizedSeeds();

    emit(
      SeedVaultState.loaded(
        seeds: seeds,
        limits: limits,
        firstRequestedPublicKey: firstRequestedPublicKey,
        lastRequestedPublicKey: lastRequestedPublicKey,
        hasUnauthorizedSeeds:
            await Wallet.instance.hasUnauthorizedSeedsForPurpose(purpose),
      ),
    );
  }

  AsyncResult<String> signMessageWithAccount(
    AuthToken authToken,
    Account account,
  ) async =>
      _signMessages(
        authToken: authToken,
        signingRequests: [
          SigningRequest(
            payload: _generateFakePayload(0),
            requestedSignatures: [account.derivationPath],
          ),
        ],
      ).letAsync((it) => it.map((it) => it.single));

  AsyncResult<String> signTransactionWithAccount(
    AuthToken authToken,
    Account account,
  ) async =>
      _signTransactions(
        authToken: authToken,
        signingRequests: [
          SigningRequest(
            payload: _generateFakePayload(0),
            requestedSignatures: [account.derivationPath],
          ),
        ],
      ).letAsync((it) => it.map((it) => it.single));

  AsyncResult<List<String>> signMessages(Seed seed) async => _signMessages(
        authToken: seed.authToken,
        signingRequests: await _generateSigningRequests(
          payloadCount: state.maybeMap(
            loaded: (it) => it.limits.maxSigningRequests,
            orElse: always(0),
          ),
          signatureCount: state.maybeMap(
            loaded: (it) => it.limits.maxRequestedSignatures,
            orElse: always(0),
          ),
        ),
      );

  AsyncResult<List<String>> signTransactions(Seed seed) async =>
      _signTransactions(
        authToken: seed.authToken,
        signingRequests: await _generateSigningRequests(
          payloadCount: state.maybeMap(
            loaded: (it) => it.limits.maxSigningRequests,
            orElse: always(0),
          ),
          signatureCount: state.maybeMap(
            loaded: (it) => it.limits.maxRequestedSignatures,
            orElse: always(0),
          ),
        ),
      );

  AsyncResult<List<String>> requestPublicKeys(Seed seed) async {
    final result = await Wallet.instance.requestPublicKeys(
      authToken: seed.authToken,
      derivationPaths: seed.accounts.map((a) => a.derivationPath).toList(),
    );

    return result
        .toEither()
        .map((it) => it.map((it) => it.publicKeyEncoded).compact().toList());
  }

  Future<void> deathorizeSeed(Seed seed) async {
    await Wallet.instance.deauthorizeSeed(seed.authToken);
  }

  AsyncResult<void> authorizeSeed() async {
    final result =
        await Wallet.instance.authorizeSeed(Purpose.signSolanaTransaction);

    await result.whenOrNull(success: _onNewSeed);

    return result.toEither();
  }

  AsyncResult<void> importSeed() async {
    final result =
        await Wallet.instance.importSeed(Purpose.signSolanaTransaction);

    await result.whenOrNull(success: _onNewSeed);

    return result.toEither();
  }

  AsyncResult<void> createSeed() async {
    final result =
        await Wallet.instance.createSeed(Purpose.signSolanaTransaction);

    await result.whenOrNull(success: _onNewSeed);

    return result.toEither();
  }

  // Mark accounts as user wallets. This simulates a real wallet app
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
          .letAsync((it) => it.whenOrNull(success: (it) => it.singleOrNull));

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

  AsyncResult<List<String>> _signMessages({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) async {
    final result = await Wallet.instance.signMessages(
      authToken: authToken,
      signingRequests: signingRequests,
    );

    return result
        .toEither()
        .map((it) => it.map((it) => it.signatures.toString()).toList());
  }

  AsyncResult<List<String>> _signTransactions({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) async {
    final result = await Wallet.instance.signTransactions(
      authToken: authToken,
      signingRequests: signingRequests,
    );

    return result
        .toEither()
        .map((it) => it.map((it) => it.signatures.toString()).toList());
  }

  Future<List<SigningRequest>> _generateSigningRequests({
    required int payloadCount,
    required int signatureCount,
  }) async {
    final maxRequestedSignatures = state.maybeMap(
      loaded: (it) => it.limits.maxRequestedSignatures,
      orElse: always(0),
    );

    return Future.wait(
      List.generate(
        payloadCount,
        (i) => Future.wait(
          List.generate(
            signatureCount,
            (j) => Bip44DerivationPath.instance.toUri(
              Bip44Data(
                account: BipLevel(
                  index: i * maxRequestedSignatures + j,
                  hardened: true,
                ),
              ),
            ),
          ),
        ).letAsync(
          (derivationPaths) => SigningRequest(
            payload: _generateFakePayload(i),
            requestedSignatures: derivationPaths,
          ),
        ),
      ),
    );
  }
}

Future<Uri> _getRequestedPublicKeyByIndex(int index) =>
    Bip32DerivationPath.instance.toUri(
      Bip32Data(levels: [BipLevel(index: index, hardened: true)]),
    );

const _firstRequestedPublicKeyIndex = 1000;
const _accountsPerSeed = 2;
const _payloadSize = 512;

Uint8List _generateFakePayload(int value) =>
    Uint8List.fromList(List.generate(_payloadSize, always(value)));

extension Ext<T> on AuthorizationResult<T> {
  Either<Exception, T> toEither() => when(
        success: Either.right,
        failed: Either.left,
      );
}
