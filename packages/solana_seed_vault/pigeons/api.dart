import 'package:pigeon/pigeon.dart';

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

  List<Map<String?, Object?>> getAuthorizedSeeds(
    List<String> projection,
    String? filterOnColumn,
    Object? value,
  );

  Map<String?, Object?> getAuthorizedSeed(
    int authToken,
    List<String> projection,
  );

  void deauthorizeSeed(int authToken);

  List<Map<String?, Object?>> getUnauthorizedSeeds(
    List<String> projection,
    String? filterOnColumn,
    Object? value,
  );

  bool hasUnauthorizedSeedsForPurpose(int purpose);

  List<Map<String?, Object?>> getAccounts(
    int authToken,
    List<String> projection,
    String? filterOnColumn,
    Object? value,
  );

  Map<String?, Object?> getAccount(
    int authToken,
    int id,
    List<String> projection,
  );

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

  List<Map<String?, Object?>> getImplementationLimits(
    List<String> projection,
    String? filterOnColumn,
    Object? value,
  );

  Map<String?, Object?> getImplementationLimitsForPurpose(int purpose);

  String resolveDerivationPath(String derivationPath, int purpose);

  bool isAvailable(bool allowSimulated);

  @async
  bool checkPermission();
}

@FlutterApi()
abstract class SeedVaultFlutterApi {
  void onChangeNotified(List<String?> uris, int flags);
}
