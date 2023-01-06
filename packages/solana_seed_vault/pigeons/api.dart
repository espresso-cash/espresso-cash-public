import 'package:pigeon/pigeon.dart';

enum AccountFilterColumnDto {
  id,
  name,
  derivationPath,
  publicKeyEncoded,
  isUserWallet,
  isValid,
}

class AccountFilterDto {
  const AccountFilterDto({
    required this.key,
    required this.value,
  });

  final AccountFilterColumnDto key;
  final String value;
}

class AccountDto {
  const AccountDto({
    required this.id,
    required this.name,
    required this.derivationPath,
    required this.publicKeyEncoded,
    required this.isUserWallet,
    required this.isValid,
  });

  final int id;
  final String name;
  final String derivationPath;
  final String publicKeyEncoded;
  final bool isUserWallet;
  final bool isValid;
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
  });

  final int maxBip32PathDepth;
  final int? maxSigningRequests;
  final int? maxRequestedSignatures;
  final int? maxRequestedPublicKeys;
}

class SigningRequestDto {
  SigningRequestDto({
    required this.payload,
    required this.requestedSignatures,
  });

  final Uint8List payload;
  final List<String?> requestedSignatures;
}

class SigningResponseDto {
  SigningResponseDto({
    required this.signatures,
    required this.resolvedDerivationPaths,
  });

  final List<Uint8List?> signatures;
  final List<String?> resolvedDerivationPaths;
}

class PublicKeyResponseDto {
  PublicKeyResponseDto({
    required this.publicKey,
    required this.publicKeyEncoded,
    required this.resolvedDerivationPath,
  });

  final Uint8List? publicKey;
  final String? publicKeyEncoded;
  final String resolvedDerivationPath;
}

@HostApi()
abstract class WalletApiHost {
  @async
  int authorizeSeed(int purpose);

  @async
  int createSeed(int purpose);

  @async
  int importSeed(int purpose);

  @async
  List<SigningResponseDto> signMessages(
    int authToken,
    List<SigningRequestDto> signingRequests,
  );

  @async
  List<SigningResponseDto> signTransactions(
    int authToken,
    List<SigningRequestDto> signingRequests,
  );

  @async
  List<PublicKeyResponseDto> requestPublicKeys(
    int authToken,
    List<String> derivationPaths,
  );

  ImplementationLimitsDto getImplementationLimitsForPurpose(int purpose);

  bool hasUnauthorizedSeedsForPurpose(int purpose);

  List<SeedDto> getAuthorizedSeeds();

  List<AccountDto> getAccounts(int authToken, AccountFilterDto? filter);

  String resolveDerivationPath(String derivationPath, int purpose);

  void deauthorizeSeed(int authToken);

  void updateAccountName(int authToken, int accountId, String? name);

  void updateAccountIsUserWallet(
    int authToken,
    int accountId,
    bool isUserWallet,
  );

  void updateAccountIsValid(
    int authToken,
    int accountId,
    bool isValid,
  );
}

@HostApi()
abstract class SeedVaultApiHost {
  bool isAvailable(bool allowSimulated);

  @async
  bool checkPermission();
}

@FlutterApi()
abstract class SeedVaultFlutterApi {
  void onChangeNotified(List<String?> uris, int flags);
}
