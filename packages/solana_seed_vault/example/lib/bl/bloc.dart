import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:wallet_example/bl/signature_verifier.dart';
import 'package:wallet_example/bl/utils.dart';

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

// ignore: avoid-cubits, just an example
class SeedVaultBloc extends Cubit<SeedVaultState> {
  SeedVaultBloc(this._signatureVerifier) : super(const SeedVaultState.none());

  final SignatureVerifier _signatureVerifier;
  late StreamSubscription<SeedVaultNotification> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }

  Future<void> init() async {
    final isInstalled =
        await SeedVault.instance.isAvailable(allowSimulated: true);

    if (!isInstalled) {
      return emit(const SeedVaultState.error('Seed vault not installed'));
    }

    final granted = await SeedVault.instance.checkPermission();

    if (granted) {
      _subscription =
          SeedVault.instance.notificationStream.listen((_) => refreshUI());

      return refreshUI();
    }

    return emit(const SeedVaultState.unauthorized());
  }

  Future<void> refreshUI() async {
    const purpose = Purpose.signSolanaTransaction;
    final limits = await SeedVault.instance
        .getParsedImplementationLimitsForPurpose(purpose);

    const firstRPKIndex = _firstRequestedPublicKeyIndex;
    final lastRPKIndex = firstRPKIndex + limits.maxRequestedPublicKeys - 1;

    final firstRequestedPublicKey = Bip32DerivationPath.toUri(
      [const BipLevel(index: firstRPKIndex, hardened: true)],
    );
    final lastRequestedPublicKey = Bip32DerivationPath.toUri(
      [BipLevel(index: lastRPKIndex, hardened: true)],
    );

    final seeds = await SeedVault.instance.getParsedAuthorizedSeeds();

    emit(
      SeedVaultState.loaded(
        seeds: seeds,
        limits: limits,
        firstRequestedPublicKey: firstRequestedPublicKey,
        lastRequestedPublicKey: lastRequestedPublicKey,
        hasUnauthorizedSeeds:
            await SeedVault.instance.hasUnauthorizedSeedsForPurpose(purpose),
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
            payload: generateFakeMessage([account.publicKeyEncoded]),
            requestedSignatures: [account.derivationPath],
          ),
        ],
      );

  AsyncResult<String> signTransactionWithAccount(
    AuthToken authToken,
    Account account,
  ) async =>
      _signTransactions(
        authToken: authToken,
        signingRequests: [
          SigningRequest(
            payload: generateFakeTransaction([account.publicKeyEncoded]),
            requestedSignatures: [account.derivationPath],
          ),
        ],
      );

  AsyncResult<String> signMessages(AuthToken authToken) async => _signMessages(
        authToken: authToken,
        signingRequests: await _generateSigningRequests(
          authToken: authToken,
          payloadCount: _maxSigningRequests,
          signatureCount: _maxRequestedSignatures,
          payloadType: _PayloadType.message,
        ),
      );

  AsyncResult<String> signTransactions(AuthToken authToken) async =>
      _signTransactions(
        authToken: authToken,
        signingRequests: await _generateSigningRequests(
          authToken: authToken,
          payloadCount: _maxSigningRequests,
          signatureCount: _maxRequestedSignatures,
          payloadType: _PayloadType.transaction,
        ),
      );

  AsyncResult<List<String>> requestPublicKeys(AuthToken authToken) async =>
      _requestPublicKeys(
        authToken,
        _generateUris(_maxRequestedPublicKeys),
      );

  AsyncResult<String> exceedMaxSigningRequests(
    AuthToken authToken,
  ) async =>
      _signTransactions(
        authToken: authToken,
        signingRequests: await _generateSigningRequests(
          authToken: authToken,
          payloadCount: _maxSigningRequests + 1,
          signatureCount: 1,
          payloadType: _PayloadType.transaction,
        ),
      );

  AsyncResult<String> exceedMaxRequestedSignatures(
    AuthToken authToken,
  ) async =>
      _signTransactions(
        authToken: authToken,
        signingRequests: await _generateSigningRequests(
          authToken: authToken,
          payloadCount: 1,
          signatureCount: _maxRequestedSignatures + 1,
          payloadType: _PayloadType.message,
        ),
      );

  AsyncResult<List<String>> exceedMaxRequestedPublicKeys(
    AuthToken authToken,
  ) async =>
      _requestPublicKeys(
        authToken,
        _generateUris(_maxRequestedPublicKeys + 1),
      );

  AsyncResult<void> updateAccountName({
    required AuthToken authToken,
    required Account account,
    required String name,
  }) =>
      SeedVault.instance
          .updateAccountName(
            authToken: authToken,
            accountId: account.id,
            name: name,
          )
          .toEither();

  Future<void> deathorizeSeed(AuthToken authToken) async {
    await SeedVault.instance.deauthorizeSeed(authToken);
  }

  AsyncResult<void> authorizeSeed() => tryEitherAsync(
        (_) async {
          await SeedVault.instance
              .authorizeSeed(Purpose.signSolanaTransaction)
              .letAsync(_onNewSeed);
        },
      );

  AsyncResult<void> importSeed() => tryEitherAsync(
        (_) async {
          await SeedVault.instance
              .importSeed(Purpose.signSolanaTransaction)
              .letAsync(_onNewSeed);
        },
      );

  AsyncResult<void> createSeed() => tryEitherAsync(
        (_) async {
          await SeedVault.instance
              .createSeed(Purpose.signSolanaTransaction)
              .letAsync(_onNewSeed);
        },
      );

  // Mark accounts as user wallets. This simulates a real wallet app
  // exploring each account and marking them as containing user funds.
  Future<void> _onNewSeed(AuthToken authToken) async {
    for (var i = 0; i < _accountsPerSeed; i++) {
      final derivationPath = Bip44DerivationPath.toUri(
        [BipLevel(index: i, hardened: true)],
      );
      final resolvedPath = await SeedVault.instance.resolveDerivationPath(
        derivationPath: derivationPath,
        purpose: Purpose.signSolanaTransaction,
      );
      final account = await SeedVault.instance
          .getParsedAccounts(
            authToken,
            filter: AccountFilter.byDerivationPath(resolvedPath),
          )
          .letAsync((it) => it.singleOrNull);

      if (account == null) return;

      if (!account.isUserWallet) {
        await SeedVault.instance.updateAccountIsUserWallet(
          authToken: authToken,
          accountId: account.id,
          isUserWallet: true,
        );
      }
    }
  }

  AsyncResult<String> _signMessages({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) =>
      tryEitherAsync(
        (_) async {
          final signingResponses = await SeedVault.instance.signMessages(
            authToken: authToken,
            signingRequests: signingRequests,
          );

          return _signatureVerifier.verify(
            authToken: authToken,
            signingRequests: signingRequests,
            signingResponses: signingResponses,
          );
        },
      );

  AsyncResult<String> _signTransactions({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) =>
      tryEitherAsync(
        (_) async {
          final signingResponses = await SeedVault.instance.signTransactions(
            authToken: authToken,
            signingRequests: signingRequests,
          );

          return _signatureVerifier.verify(
            authToken: authToken,
            signingRequests: signingRequests,
            signingResponses: signingResponses,
          );
        },
      );

  AsyncResult<List<String>> _requestPublicKeys(
    AuthToken authToken,
    List<Uri> uris,
  ) =>
      tryEitherAsync(
        (_) async {
          final result = await SeedVault.instance.requestPublicKeys(
            authToken: authToken,
            derivationPaths: uris,
          );

          return result.map((it) => it.publicKeyEncoded).compact().toList();
        },
      );

  List<Uri> _generateUris(int count) => List.generate(
        count,
        (i) => Bip32DerivationPath.toUri([BipLevel(index: i, hardened: true)]),
      );

  Future<List<SigningRequest>> _generateSigningRequests({
    required AuthToken authToken,
    required int payloadCount,
    required int signatureCount,
    required _PayloadType payloadType,
  }) async {
    final maxRequestedSignatures = _maxRequestedSignatures;

    return Future.wait(
      List.generate(
        payloadCount,
        (i) => List.generate(
          signatureCount,
          (j) => Bip44DerivationPath.toUri([
            BipLevel(
              index: i * maxRequestedSignatures + j,
              hardened: true,
            ),
          ]),
        ).let(
          (it) => getPublicKeysFromPaths(authToken, it).letAsync(
            (signers) => SigningRequest(
              payload: payloadType == _PayloadType.message
                  ? generateFakeMessage(
                      signers.map((it) => it.toBase58()).toList(),
                    )
                  : generateFakeTransaction(
                      signers.map((it) => it.toBase58()).toList(),
                    ),
              requestedSignatures: it,
            ),
          ),
        ),
      ),
    );
  }

  int get _maxSigningRequests => state.maybeMap(
        orElse: always(0),
        loaded: (it) => it.limits.maxSigningRequests,
      );

  int get _maxRequestedSignatures => state.maybeMap(
        orElse: always(0),
        loaded: (it) => it.limits.maxRequestedSignatures,
      );

  int get _maxRequestedPublicKeys => state.maybeMap(
        orElse: always(0),
        loaded: (it) => it.limits.maxRequestedPublicKeys,
      );
}

const _firstRequestedPublicKeyIndex = 1000;
const _accountsPerSeed = 2;

enum _PayloadType { message, transaction }
