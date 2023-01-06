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
        await _generateUris(_maxRequestedPublicKeys),
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
        await _generateUris(_maxRequestedPublicKeys + 1),
      );

  AsyncResult<void> updateAccountName({
    required AuthToken authToken,
    required Account account,
    required String name,
  }) =>
      Wallet.instance
          .updateAccountName(
            authToken: authToken,
            accountId: account.id,
            name: name,
          )
          .toEither();

  Future<void> deathorizeSeed(AuthToken authToken) async {
    await Wallet.instance.deauthorizeSeed(authToken);
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

  AsyncResult<String> _signMessages({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) async {
    final result = await Wallet.instance.signMessages(
      authToken: authToken,
      signingRequests: signingRequests,
    );

    return result.toEither().mapAsync(
          (signingResponses) => _signatureVerifier.verify(
            authToken: authToken,
            signingRequests: signingRequests,
            signingResponses: signingResponses,
          ),
        );
  }

  AsyncResult<String> _signTransactions({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) async {
    final result = await Wallet.instance.signTransactions(
      authToken: authToken,
      signingRequests: signingRequests,
    );

    return result.toEither().mapAsync(
          (signingResponses) => _signatureVerifier.verify(
            authToken: authToken,
            signingRequests: signingRequests,
            signingResponses: signingResponses,
          ),
        );
  }

  AsyncResult<List<String>> _requestPublicKeys(
    AuthToken authToken,
    List<Uri> uris,
  ) async {
    final result = await Wallet.instance.requestPublicKeys(
      authToken: authToken,
      derivationPaths: uris,
    );

    return result
        .toEither()
        .map((it) => it.map((it) => it.publicKeyEncoded).compact().toList());
  }

  Future<List<Uri>> _generateUris(int count) async => Future.wait(
        List.generate(
          count,
          (i) => Bip32DerivationPath.instance.toUri(
            Bip32Data(levels: [BipLevel(index: i, hardened: true)]),
          ),
        ),
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

Future<Uri> _getRequestedPublicKeyByIndex(int index) =>
    Bip32DerivationPath.instance.toUri(
      Bip32Data(levels: [BipLevel(index: index, hardened: true)]),
    );

const _firstRequestedPublicKeyIndex = 1000;
const _accountsPerSeed = 2;

extension Ext<T> on AuthorizationResult<T> {
  Either<Exception, T> toEither() => when(
        success: Either.right,
        failed: Either.left,
      );
}

enum _PayloadType { message, transaction }
