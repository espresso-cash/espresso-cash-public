import 'package:pigeon/pigeon.dart';

enum Purpose {
  signSolanaTransaction,
}

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
  final Purpose purpose;
  final List<AccountDto?> accounts;
}

@HostApi()
abstract class ApiHost {
  Map<String, int> getImplementationLimitsForPurpose(Purpose purpose);

  bool hasUnauthorizedSeedsForPurpose(Purpose purpose);

  bool isAvailable(bool allowSimulated);

  List<SeedDto> getAuthorizedSeeds();

  List<AccountDto> getAccounts(int authToken);
}
