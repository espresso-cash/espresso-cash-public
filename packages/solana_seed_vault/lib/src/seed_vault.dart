import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:solana_seed_vault/src/api.dart';
import 'package:solana_seed_vault/src/models/auth_token.dart';
import 'package:solana_seed_vault/src/models/public_key_response.dart';
import 'package:solana_seed_vault/src/models/seed.dart';
import 'package:solana_seed_vault/src/models/seed_vault_notification.dart';
import 'package:solana_seed_vault/src/models/signing_request.dart';
import 'package:solana_seed_vault/src/models/signing_response.dart';
import 'package:solana_seed_vault/src/wallet_contract_v1.dart';

typedef CursorData = Map<Object?, Object?>;

class SeedVault implements SeedVaultFlutterApi {
  @visibleForTesting
  SeedVault(this._platform);

  SeedVault._(this._platform) {
    SeedVaultFlutterApi.setup(this);
  }

  final WalletApiHost _platform;

  static var _instance = SeedVault._(WalletApiHost());

  static SeedVault get instance => _instance;

  Stream<SeedVaultNotification> get notificationStream => _eventStream.stream;

  @visibleForTesting
  static set instance(SeedVault vault) => _instance = vault;

  final _eventStream = StreamController<SeedVaultNotification>.broadcast();

  @override
  void onChangeNotified(List<String?> uris, int flags) {
    _eventStream.add(
      SeedVaultNotification(
        uris: uris.whereType<String>().map(Uri.parse).toList(),
        flags: flags,
      ),
    );
  }

  Future<bool> isAvailable({bool allowSimulated = false}) async {
    if (!Platform.isAndroid) return false;

    return _platform.isAvailable(allowSimulated);
  }

  Future<bool> checkPermission() => _platform.checkPermission();

  Future<List<CursorData>> getAuthorizedSeeds({
    List<String> projection = WalletContractV1.authorizedSeedsAllColumns,
    String? filterOnColumn,
    Object? value,
  }) =>
      _platform
          .getAuthorizedSeeds(projection, filterOnColumn, value)
          .then(_compact);

  Future<CursorData> getAuthorizedSeed({
    required AuthToken authToken,
    List<String> projection = WalletContractV1.authorizedSeedsAllColumns,
  }) =>
      _platform.getAuthorizedSeed(authToken, projection);

  Future<List<CursorData>> getUnauthorizedSeeds({
    List<String> projection = WalletContractV1.unauthorizedSeedsAllColumns,
    String? filterOnColumn,
    Object? value,
  }) =>
      _platform
          .getUnauthorizedSeeds(projection, filterOnColumn, value)
          .then(_compact);

  Future<List<CursorData>> getAccounts({
    required AuthToken authToken,
    List<String> projection = WalletContractV1.accountsAllColumns,
    String? filterOnColumn,
    Object? value,
  }) =>
      _platform
          .getAccounts(authToken, projection, filterOnColumn, value)
          .then(_compact);

  Future<CursorData> getAccount({
    required int authToken,
    required int id,
    List<String> projection = WalletContractV1.accountsAllColumns,
  }) =>
      _platform.getAccount(authToken, id, projection);

  Future<void> updateAccountName({
    required AuthToken authToken,
    required int accountId,
    required String? name,
  }) =>
      _platform.updateAccountName(authToken, accountId, name);

  Future<void> updateAccountIsUserWallet({
    required AuthToken authToken,
    required int accountId,
    required bool isUserWallet,
  }) =>
      _platform.updateAccountIsUserWallet(
        authToken,
        accountId,
        isUserWallet,
      );

  Future<void> updateAccountIsValid({
    required AuthToken authToken,
    required int accountId,
    required bool isValid,
  }) =>
      _platform.updateAccountIsValid(authToken, accountId, isValid);

  Future<Uri> resolveDerivationPath({
    required Uri derivationPath,
    required Purpose purpose,
  }) =>
      _platform
          .resolveDerivationPath(derivationPath.toString(), purpose.index)
          .then(Uri.parse);

  Future<void> deauthorizeSeed(AuthToken authToken) =>
      _platform.deauthorizeSeed(authToken);

  Future<List<CursorData>> getImplementationLimits({
    List<String> projection = WalletContractV1.implementationLimitsAllColumns,
    String? filterOnColumn,
    Object? value,
  }) =>
      _platform
          .getImplementationLimits(projection, filterOnColumn, value)
          .then(_compact);

  Future<CursorData> getImplementationLimitsForPurpose(Purpose purpose) =>
      _platform.getImplementationLimitsForPurpose(purpose.index);

  Future<bool> hasUnauthorizedSeedsForPurpose(Purpose purpose) =>
      _platform.hasUnauthorizedSeedsForPurpose(purpose.index);

  Future<AuthToken> authorizeSeed(Purpose purpose) =>
      _platform.authorizeSeed(purpose.index);

  Future<AuthToken> createSeed(Purpose purpose) =>
      _platform.createSeed(purpose.index);

  Future<AuthToken> importSeed(Purpose purpose) =>
      _platform.importSeed(purpose.index);

  Future<List<PublicKeyResponse>> requestPublicKeys({
    required AuthToken authToken,
    required List<Uri> derivationPaths,
  }) async {
    final paths = derivationPaths.map((it) => it.toString()).toList();

    final results = await _platform.requestPublicKeys(authToken, paths);

    return results
        .whereType<PublicKeyResponseDto>()
        .map(
          (it) => PublicKeyResponse(
            publicKey: it.publicKey,
            publicKeyEncoded: it.publicKeyEncoded,
            resolvedDerivationPath: Uri.parse(it.resolvedDerivationPath),
          ),
        )
        .toList();
  }

  Future<List<SigningResponse>> signMessages({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) async {
    final requests = signingRequests.map((it) => it.toDto()).toList();

    final results = await _platform.signMessages(authToken, requests);

    return results
        .whereType<SigningResponseDto>()
        .map((it) => it.toModel())
        .toList();
  }

  Future<List<SigningResponse>> signTransactions({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) async {
    final requests = signingRequests.map((it) => it.toDto()).toList();

    final results = await _platform.signTransactions(authToken, requests);

    return results
        .whereType<SigningResponseDto>()
        .map((it) => it.toModel())
        .toList();
  }
}

extension on SigningRequest {
  SigningRequestDto toDto() => SigningRequestDto(
        payload: payload,
        requestedSignatures:
            requestedSignatures.map((it) => it.toString()).toList(),
      );
}

extension on SigningResponseDto {
  SigningResponse toModel() => SigningResponse(
        signatures: signatures.whereType<Uint8List>().toList(),
        resolvedDerivationPaths:
            resolvedDerivationPaths.whereType<String>().map(Uri.parse).toList(),
      );
}

List<CursorData> _compact(List<Map<Object?, Object?>?> list) =>
    list.whereType<Map<Object?, Object?>>().toList();
