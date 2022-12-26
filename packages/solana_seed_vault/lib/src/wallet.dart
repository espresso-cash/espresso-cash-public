import 'package:dfunc/dfunc.dart';
import 'package:meta/meta.dart';
import 'package:solana_seed_vault/src/api.dart';
import 'package:solana_seed_vault/src/models/account.dart';
import 'package:solana_seed_vault/src/models/implementation_limits.dart';
import 'package:solana_seed_vault/src/models/seed.dart';

abstract class WalletPermission {
  static const accessSeedVault = 'com.solanamobile.seedvault.ACCESS_SEED_VAULT';
}

class Wallet {
  Wallet._(this._platform);

  final WalletApiHost _platform;

  static var _instance = Wallet._(WalletApiHost());

  static Wallet get instance => _instance;

  @visibleForTesting
  static set instance(Wallet wallet) => _instance = wallet;

  Future<void> authorizeSeed(Purpose purpose) =>
      _platform.authorizeSeed(purpose.index);

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
    int authToken, {
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
    required int authToken,
    required int accountId,
    required String? name,
  }) =>
      _platform.updateAccountName(authToken, accountId, name);

  Future<void> updateAccountIsUserWallet({
    required int authToken,
    required int accountId,
    required bool isUserWallet,
  }) =>
      _platform.updateAccountIsUserWallet(authToken, accountId, isUserWallet);

  Future<void> updateAccountIsValid({
    required int authToken,
    required int accountId,
    required bool isValid,
  }) =>
      _platform.updateAccountIsValid(authToken, accountId, isValid);

  Future<void> deauthorizeSeed(int authToken) =>
      _platform.deauthorizeSeed(authToken);

  Future<bool> hasUnauthorizedSeedsForPurpose(Purpose purpose) =>
      _platform.hasUnauthorizedSeedsForPurpose(purpose.index);

  Future<bool> isAvailable(bool allowSimulated) =>
      _platform.isAvailable(allowSimulated);
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
