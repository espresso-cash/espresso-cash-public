import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:solana_seed_vault/src/api.dart';
import 'package:solana_seed_vault/src/extensions.dart';
import 'package:solana_seed_vault/src/models/account.dart';
import 'package:solana_seed_vault/src/models/auth_token.dart';
import 'package:solana_seed_vault/src/models/authorization_result.dart';
import 'package:solana_seed_vault/src/models/filter.dart';
import 'package:solana_seed_vault/src/models/implementation_limits.dart';
import 'package:solana_seed_vault/src/models/public_key_response.dart';
import 'package:solana_seed_vault/src/models/seed.dart';
import 'package:solana_seed_vault/src/models/seed_vault_notification.dart';
import 'package:solana_seed_vault/src/models/signing_request.dart';
import 'package:solana_seed_vault/src/models/signing_response.dart';

typedef AsyncAuthorizationResult<T> = Future<AuthorizationResult<T>>;

class Wallet implements SeedVaultFlutterApi {
  Wallet._(this._platform) {
    SeedVaultFlutterApi.setup(this);
  }

  final WalletApiHost _platform;

  static var _instance = Wallet._(WalletApiHost());

  static Wallet get instance => _instance;

  Stream<SeedVaultNotification> get changeStream => _eventStream.stream;

  @visibleForTesting
  static set instance(Wallet wallet) => _instance = wallet;

  final _eventStream = StreamController<SeedVaultNotification>();

  @override
  void onChangeNotified(List<String?> uris, int flags) {
    _eventStream.add(
      SeedVaultNotification(
        uris: uris.compact().map(Uri.parse).toList(),
        flags: flags,
      ),
    );
  }

  Future<ImplementationLimits> getImplementationLimitsForPurpose(
    Purpose purpose,
  ) async {
    final dto =
        await _platform.getImplementationLimitsForPurpose(purpose.index);

    return ImplementationLimits(
      maxBip32PathDepth: dto.maxBip32PathDepth,
      maxSigningRequests: dto.maxSigningRequests ?? 0,
      maxRequestedSignatures: dto.maxRequestedSignatures ?? 0,
      maxRequestedPublicKeys: dto.maxRequestedPublicKeys ?? 0,
    );
  }

  Future<List<Seed>> getAuthorizedSeeds() async {
    final seeds = await _platform.getAuthorizedSeeds();

    return seeds
        .compact()
        .map(
          (it) => Seed(
            authToken: it.authToken,
            name: it.name,
            purpose: Purpose.values.elementAt(it.purpose),
            accounts: it.accounts.toModelList(),
          ),
        )
        .toList();
  }

  Future<Uri> resolveDerivationPath({
    required Uri derivationPath,
    required Purpose purpose,
  }) async {
    final encoded = await _platform.resolveDerivationPath(
      derivationPath.toString(),
      purpose.index,
    );

    return Uri.parse(encoded);
  }

  AsyncAuthorizationResult<List<Account>> getAccounts(
    AuthToken authToken, {
    AccountFilter filter = const AccountFilter(),
  }) =>
      _handleAuthResult(() async {
        final accounts = await _platform.getAccounts(authToken, filter.toDto());

        return accounts.toModelList();
      });

  AsyncAuthorizationResult<void> updateAccountName({
    required AuthToken authToken,
    required int accountId,
    required String? name,
  }) =>
      _handleAuthResult(
        () => _platform.updateAccountName(authToken, accountId, name),
      );

  AsyncAuthorizationResult<void> updateAccountIsUserWallet({
    required AuthToken authToken,
    required int accountId,
    required bool isUserWallet,
  }) =>
      _handleAuthResult(
        () => _platform.updateAccountIsUserWallet(
          authToken,
          accountId,
          isUserWallet,
        ),
      );

  AsyncAuthorizationResult<void> updateAccountIsValid({
    required AuthToken authToken,
    required int accountId,
    required bool isValid,
  }) =>
      _handleAuthResult(
        () => _platform.updateAccountIsValid(authToken, accountId, isValid),
      );

  AsyncAuthorizationResult<void> deauthorizeSeed(AuthToken authToken) =>
      _handleAuthResult(() => _platform.deauthorizeSeed(authToken));

  Future<bool> hasUnauthorizedSeedsForPurpose(Purpose purpose) =>
      _platform.hasUnauthorizedSeedsForPurpose(purpose.index);

  AsyncAuthorizationResult<AuthToken> authorizeSeed(Purpose purpose) =>
      _handleAuthResult(() => _platform.authorizeSeed(purpose.index));

  AsyncAuthorizationResult<AuthToken> createSeed(Purpose purpose) =>
      _handleAuthResult(() => _platform.createSeed(purpose.index));

  AsyncAuthorizationResult<AuthToken> importSeed(Purpose purpose) =>
      _handleAuthResult(() => _platform.importSeed(purpose.index));

  AsyncAuthorizationResult<List<PublicKeyResponse>> requestPublicKeys({
    required AuthToken authToken,
    required List<Uri> derivationPaths,
  }) =>
      _handleAuthResult(() async {
        final paths = derivationPaths.map((it) => it.toString()).toList();

        final results = await _platform.requestPublicKeys(authToken, paths);

        return results
            .compact()
            .map(
              (it) => PublicKeyResponse(
                publicKey: it.publicKey,
                publicKeyEncoded: it.publicKeyEncoded,
                resolvedDerivationPath: Uri.parse(it.resolvedDerivationPath),
              ),
            )
            .toList();
      });

  AsyncAuthorizationResult<List<SigningResponse>> signMessages({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) =>
      _handleAuthResult(() async {
        final requests = signingRequests.map((it) => it.toDto()).toList();

        final results = await _platform.signMessages(authToken, requests);

        return results.compact().map((it) => it.toModel()).toList();
      });

  AsyncAuthorizationResult<List<SigningResponse>> signTransactions({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) =>
      _handleAuthResult(() async {
        final requests = signingRequests.map((it) => it.toDto()).toList();

        final results = await _platform.signTransactions(authToken, requests);

        return results.compact().map((it) => it.toModel()).toList();
      });
}

Future<AuthorizationResult<T>> _handleAuthResult<T>(
  AsyncValueGetter<T> request,
) async {
  try {
    return AuthorizationResult.success(await request());
  } on PlatformException catch (e) {
    return AuthorizationResult.failed(e);
  }
}
