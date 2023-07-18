// ignore_for_file: avoid_positional_boolean_parameters

import 'package:pigeon/pigeon.dart';

class SigningRequestDto {
  const SigningRequestDto({
    required this.payload,
    required this.requestedSignatures,
  });

  final Uint8List payload;
  final List<String?> requestedSignatures;
}

class SigningResponseDto {
  const SigningResponseDto({
    required this.signatures,
    required this.resolvedDerivationPaths,
  });

  final List<Uint8List?> signatures;
  final List<String?> resolvedDerivationPaths;
}

class PublicKeyResponseDto {
  const PublicKeyResponseDto({
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
  const WalletApiHost();
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

  List<Map<Object?, Object?>> getAuthorizedSeeds(
    List<String> projection,
    String? filterOnColumn,
    Object? value,
  );

  Map<Object?, Object?> getAuthorizedSeed(
    int authToken,
    List<String> projection,
  );

  void deauthorizeSeed(int authToken);

  List<Map<Object?, Object?>> getUnauthorizedSeeds(
    List<String> projection,
    String? filterOnColumn,
    Object? value,
  );

  bool hasUnauthorizedSeedsForPurpose(int purpose);

  List<Map<Object?, Object?>> getAccounts(
    int authToken,
    List<String> projection,
    String? filterOnColumn,
    Object? value,
  );

  Map<Object?, Object?> getAccount(
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

  List<Map<Object?, Object?>> getImplementationLimits(
    List<String> projection,
    String? filterOnColumn,
    Object? value,
  );

  Map<Object?, Object?> getImplementationLimitsForPurpose(int purpose);

  String resolveDerivationPath(String derivationPath, int purpose);

  bool isAvailable(bool allowSimulated);

  @async
  bool checkPermission();
}

@FlutterApi()
abstract class SeedVaultFlutterApi {
  const SeedVaultFlutterApi();
  void onChangeNotified(List<String?> uris, int flags);
}
