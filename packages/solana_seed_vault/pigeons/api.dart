import 'package:pigeon/pigeon.dart';

class AccountDto {
  const AccountDto({
    required this.id,
    required this.name,
    required this.derivationPath,
    required this.publicKeyEncoded,
  });

  final int id;
  final String name;
  final String derivationPath;
  final String publicKeyEncoded;
}

class SeedDto {
  const SeedDto({
    required this.authToken,
    required this.name,
    required this.purpose,
    required this.accounts,
  });

  final int authToken;
  final String name;
  final int purpose;
  final List<AccountDto?> accounts;
}

class ImplementationLimitsDto {
  const ImplementationLimitsDto({
    required this.maxBip32PathDepth,
    required this.maxSigningRequests,
    required this.maxRequestedSignatures,
    required this.maxRequestedPublicKeys,
    required this.authPurpose,
  });

  final int maxBip32PathDepth;
  final int? maxSigningRequests;
  final int? maxRequestedSignatures;
  final int? maxRequestedPublicKeys;
  final int? authPurpose;
}

@HostApi()
abstract class ApiHost {
  ImplementationLimitsDto getImplementationLimitsForPurpose(int purpose);

  bool hasUnauthorizedSeedsForPurpose(int purpose);

  bool isAvailable(bool allowSimulated);

  List<SeedDto> getAuthorizedSeeds();

  List<AccountDto> getAccounts(int authToken);

  // TODO(rhbrunetto): move to Bip32DerivationPath
  String getAccountByLevel(int bipLevel);

  String resolveDerivationPath(int bipLevel);
}
