import 'package:dfunc/dfunc.dart';
import 'package:meta/meta.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:solana_seed_vault/src/api.dart';

abstract class WalletPermission {
  static const accessSeedVault = 'com.solanamobile.seedvault.ACCESS_SEED_VAULT';
}

class Wallet {
  Wallet._(this._platform);

  final ApiHost _platform;

  static var _instance = Wallet._(ApiHost());

  static Wallet get instance => _instance;

  @visibleForTesting
  static set instance(Wallet wallet) => _instance = wallet;

  Future<Uri?> getAccountByLevel(int level) =>
      _platform.getAccountByLevel(level).letAsync(Uri.tryParse);

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
      authPurpose: dto.authPurpose ?? 0,
    );
  }

  Future<bool> hasUnauthorizedSeedsForPurpose(Purpose purpose) =>
      _platform.hasUnauthorizedSeedsForPurpose(purpose.index);

  Future<bool> isAvailable(bool allowSimulated) =>
      _platform.isAvailable(allowSimulated);

  Future<List<Seed>> getAuthorizedSeeds() =>
      _platform.getAuthorizedSeeds().letAsync(
            (dtos) => dtos
                .compact()
                .map(
                  (it) => Seed(
                    authToken: it.authToken,
                    name: it.name,
                    purpose: Purpose.values.elementAt(it.purpose),
                    accounts: it.accounts.toModelList(),
                  ),
                )
                .toList(),
          );

  Future<List<Account>> getAccounts(int authToken) =>
      _platform.getAccounts(authToken).letAsync((dtos) => dtos.toModelList());
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
        ),
      )
      .toList();
}
