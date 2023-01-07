import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:solana_seed_vault/src/api.dart';
import 'package:solana_seed_vault/src/extensions.dart';
import 'package:solana_seed_vault/src/models/auth_token.dart';
import 'package:solana_seed_vault/src/models/authorization_result.dart';
import 'package:solana_seed_vault/src/models/public_key_response.dart';
import 'package:solana_seed_vault/src/models/seed.dart';
import 'package:solana_seed_vault/src/models/seed_vault_notification.dart';
import 'package:solana_seed_vault/src/models/signing_request.dart';
import 'package:solana_seed_vault/src/models/signing_response.dart';
import 'package:solana_seed_vault/src/wallet_contract_v1.dart';

typedef CursorData = Map<String, dynamic>;

typedef AsyncAuthorizationResult<T> = Future<AuthorizationResult<T>>;

class SeedVaultWallet implements SeedVaultFlutterApi {
  @visibleForTesting
  SeedVaultWallet(this._platform);

  SeedVaultWallet._(this._platform) {
    SeedVaultFlutterApi.setup(this);
  }

  final WalletApiHost _platform;

  static var _instance = SeedVaultWallet._(WalletApiHost());

  static SeedVaultWallet get instance => _instance;

  Stream<SeedVaultNotification> get notificationStream => _eventStream.stream;

  @visibleForTesting
  static set instance(SeedVaultWallet wallet) => _instance = wallet;

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

  Future<bool> isAvailable(bool allowSimulated) =>
      _platform.isAvailable(allowSimulated);

  Future<bool> checkPermission() => _platform.checkPermission();

  Future<List<CursorData>> getAuthorizedSeeds({
    List<String> projection = WalletContractV1.authorizedSeedsAllColumns,
    String? filterOnColumn,
    Object? value,
  }) =>
      _platform
          .getAuthorizedSeeds(projection, filterOnColumn, value)
          .letAsync(_castList);

  AsyncAuthorizationResult<CursorData> getAuthorizedSeed({
    required AuthToken authToken,
    List<String> projection = WalletContractV1.authorizedSeedsAllColumns,
  }) =>
      _handleAuthResult(
        () =>
            _platform.getAuthorizedSeed(authToken, projection).letAsync(_cast),
      );

  Future<List<CursorData>> getUnauthorizedSeeds({
    List<String> projection = WalletContractV1.unauthorizedSeedsAllColumns,
    String? filterOnColumn,
    Object? value,
  }) =>
      _platform
          .getUnauthorizedSeeds(projection, filterOnColumn, value)
          .letAsync(_castList);

  AsyncAuthorizationResult<List<CursorData>> getAccounts({
    required AuthToken authToken,
    List<String> projection = WalletContractV1.accountsAllColumns,
    String? filterOnColumn,
    Object? value,
  }) =>
      _handleAuthResult(
        () => _platform
            .getAccounts(authToken, projection, filterOnColumn, value)
            .letAsync(_castList),
      );

  AsyncAuthorizationResult<CursorData> getAccount({
    required int authToken,
    required int id,
    List<String> projection = WalletContractV1.accountsAllColumns,
  }) =>
      _handleAuthResult(
        () => _platform.getAccount(authToken, id, projection).letAsync(_cast),
      );

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

  Future<List<CursorData>> getImplementationLimits({
    List<String> projection = WalletContractV1.implementationLimitsAllColumns,
    String? filterOnColumn,
    Object? value,
  }) =>
      _platform
          .getImplementationLimits(projection, filterOnColumn, value)
          .letAsync(_castList);

  Future<CursorData> getImplementationLimitsForPurpose(Purpose purpose) =>
      _platform
          .getImplementationLimitsForPurpose(purpose.index)
          .letAsync(_cast);

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
) =>
    tryEitherAsync<T>((_) => request()).foldAsync(
      AuthorizationResult<T>.failed,
      AuthorizationResult<T>.success,
    );

List<CursorData> _castList(List<Map<String?, Object?>?> list) =>
    list.map((it) => it?.let(_cast)).compact().toList();

CursorData _cast(Map<String?, Object?> data) => data.cast<String, dynamic>();
