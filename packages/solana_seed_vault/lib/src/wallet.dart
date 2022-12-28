import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:solana_seed_vault/src/api.dart';
import 'package:solana_seed_vault/src/models/account.dart';
import 'package:solana_seed_vault/src/models/auth_token.dart';
import 'package:solana_seed_vault/src/models/auth_token_response.dart';
import 'package:solana_seed_vault/src/models/implementation_limits.dart';
import 'package:solana_seed_vault/src/models/public_key_response.dart';
import 'package:solana_seed_vault/src/models/seed.dart';
import 'package:solana_seed_vault/src/models/seed_vault_notification.dart';
import 'package:solana_seed_vault/src/models/signing_request.dart';
import 'package:solana_seed_vault/src/models/signing_response.dart';

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

  Future<List<Account>> getAccounts(
    AuthToken authToken, {
    bool userWalletOnly = true,
  }) async {
    final accounts = await _platform.getAccounts(authToken, userWalletOnly);

    return accounts.toModelList();
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
      _platform.updateAccountIsUserWallet(authToken, accountId, isUserWallet);

  Future<void> updateAccountIsValid({
    required AuthToken authToken,
    required int accountId,
    required bool isValid,
  }) =>
      _platform.updateAccountIsValid(authToken, accountId, isValid);

  Future<void> deauthorizeSeed(AuthToken authToken) =>
      _platform.deauthorizeSeed(authToken);

  Future<bool> hasUnauthorizedSeedsForPurpose(Purpose purpose) =>
      _platform.hasUnauthorizedSeedsForPurpose(purpose.index);

  Future<AuthTokenResponse> authorizeSeed(Purpose purpose) =>
      _handleAuthTokenResponse(() => _platform.authorizeSeed(purpose.index));

  Future<AuthTokenResponse> createSeed(Purpose purpose) =>
      _handleAuthTokenResponse(() => _platform.createSeed(purpose.index));

  Future<AuthTokenResponse> importSeed(Purpose purpose) =>
      _handleAuthTokenResponse(() => _platform.importSeed(purpose.index));

  Future<List<PublicKeyResponse>> requestPublicKeys({
    required AuthToken authToken,
    required List<Uri> derivationPaths,
  }) async {
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
  }

  Future<List<SigningResponse>> signMessages({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) async {
    final requests = signingRequests.map((it) => it.toDto()).toList();

    final results = await _platform.signMessages(authToken, requests);

    return results.compact().map((it) => it.toModel()).toList();
  }

  Future<List<SigningResponse>> signTransactions({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
  }) async {
    final requests = signingRequests.map((it) => it.toDto()).toList();

    final results = await _platform.signTransactions(authToken, requests);

    return results.compact().map((it) => it.toModel()).toList();
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
        signatures: signatures.compact().toList(),
        resolvedDerivationPaths:
            resolvedDerivationPaths.compact().map(Uri.parse).toList(),
      );
}

extension on List<AccountDto?> {
  List<Account> toModelList() => this
      .compact()
      .map(
        (it) => Account(
          id: it.id,
          name: it.name,
          derivationPath: Uri.parse(it.derivationPath),
          publicKeyEncoded: it.publicKeyEncoded,
          isUserWallet: it.isUserWallet,
          isValid: it.isValid,
        ),
      )
      .toList();
}

Future<AuthTokenResponse> _handleAuthTokenResponse(
  AsyncValueGetter<AuthToken> onResult,
) async {
  try {
    return AuthTokenResponse.success(await onResult());
  } on Exception catch (e) {
    return AuthTokenResponse.failure(e);
  }
}
