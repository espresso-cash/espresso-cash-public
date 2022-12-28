import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:solana_seed_vault/src/api.dart';
import 'package:solana_seed_vault/src/models/account.dart';
import 'package:solana_seed_vault/src/models/auth_token.dart';
import 'package:solana_seed_vault/src/models/auth_token_response.dart';
import 'package:solana_seed_vault/src/models/implementation_limits.dart';
import 'package:solana_seed_vault/src/models/public_key.dart';
import 'package:solana_seed_vault/src/models/seed.dart';
import 'package:solana_seed_vault/src/models/signing.dart';

enum PayloadType { message, transaction }

class Wallet {
  Wallet._(this._platform);

  final WalletApiHost _platform;

  static var _instance = Wallet._(WalletApiHost());

  static Wallet get instance => _instance;

  @visibleForTesting
  static set instance(Wallet wallet) => _instance = wallet;

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
    AccountFilter filter = const AccountFilter.isUserWallet(),
  }) async {
    final accounts = await _platform.getAccounts(
      authToken,
      filter.map(any: F, isUserWallet: T),
    );

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

  Future<List<SigningResponse>> signPayload({
    required AuthToken authToken,
    required List<SigningRequest> signingRequests,
    required PayloadType payloadType,
  }) async {
    final r = signingRequests
        .map(
          (it) => SigningRequestDto(
            payload: it.payload,
            requestedSignatures:
                it.requestedSignatures.map((it) => it.toString()).toList(),
          ),
        )
        .toList();

    final results = payloadType == PayloadType.message
        ? await _platform.signMessages(authToken, r)
        : await _platform.signTransactions(authToken, r);

    return results
        .compact()
        .map(
          (it) => SigningResponse(
            signatures: it.signatures.compact().toList(),
            resolvedDerivationPaths:
                it.resolvedDerivationPaths.compact().map(Uri.parse).toList(),
          ),
        )
        .toList();
  }

  Future<List<PublicKeyResponse>> requestPublicKeys({
    required AuthToken authToken,
    required List<Uri> derivationPaths,
  }) async {
    final r = derivationPaths.map((it) => it.toString()).toList();

    final results = await _platform.requestPublicKeys(authToken, r);

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
