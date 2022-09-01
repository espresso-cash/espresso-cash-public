import 'package:pigeon/pigeon.dart';

class AuthorizeRequestDto {
  AuthorizeRequestDto({
    required this.identityName,
    required this.identityUri,
    required this.iconUri,
  });

  final String? identityName;
  final String? identityUri;
  final String? iconUri;
}

class AuthorizeResultDto {
  AuthorizeResultDto({
    required this.publicKey,
    required this.accountLabel,
    required this.walletUriBase,
    required this.scope,
  });

  final Uint8List publicKey;
  final String? accountLabel;
  final String? walletUriBase;
  final Uint8List? scope;
}

abstract class BaseVerifiableIdentityRequestDto {
  BaseVerifiableIdentityRequestDto({
    required this.identityName,
    required this.identityUri,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  final String? identityName;
  final String? identityUri;
  final String? iconRelativeUri;
  final String cluster;
  final Uint8List authorizationScope;
}

class ReauthorizeRequestDto implements BaseVerifiableIdentityRequestDto {
  ReauthorizeRequestDto({
    required this.identityUri,
    required this.identityName,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  @override
  final String? identityName;

  @override
  final String? identityUri;

  @override
  final String? iconRelativeUri;

  @override
  final String cluster;

  @override
  final Uint8List authorizationScope;
}

class SignPayloadsRequestDto implements BaseVerifiableIdentityRequestDto {
  SignPayloadsRequestDto({
    required this.identityUri,
    required this.identityName,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  @override
  final String? identityName;

  @override
  final String? identityUri;

  @override
  final String? iconRelativeUri;

  @override
  final String cluster;

  @override
  final Uint8List authorizationScope;
}

class SignedPayloadsResultDto {
  SignedPayloadsResultDto({
    required this.payloads,
    required this.error,
    required this.validPayloads,
  });

  final List<Uint8List?>? payloads;
  final MobileWalletAdapterServerException? error;
  final List<bool?>? validPayloads;
}

enum MobileWalletAdapterServerException {
  requestDeclined,
  invalidPayloads,
  tooManyPayloads,
  authorizationNotValid,
}

class RequestDeclinedException {}

class InvalidPayloadsException {
  InvalidPayloadsException({required this.valid});

  final List<bool?> valid;
}

class TooManyPayloadsException {}

class AuthorizationNotValidException {}

class SignTransactionsRequestDto implements SignPayloadsRequestDto {
  SignTransactionsRequestDto({
    required this.payloads,
    required this.identityUri,
    required this.identityName,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  final List<Uint8List?> payloads;

  @override
  final String? identityName;

  @override
  final String? identityUri;

  @override
  final String? iconRelativeUri;

  @override
  final String cluster;

  @override
  final Uint8List authorizationScope;
}

class SignMessagesRequestDto implements SignPayloadsRequestDto {
  SignMessagesRequestDto({
    required this.payloads,
    required this.identityUri,
    required this.identityName,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  final List<Uint8List?> payloads;

  @override
  final String? identityName;

  @override
  final String? identityUri;

  @override
  final String? iconRelativeUri;

  @override
  final String cluster;

  @override
  final Uint8List authorizationScope;
}

class SignAndSendTransactionsRequestDto
    implements BaseVerifiableIdentityRequestDto {
  SignAndSendTransactionsRequestDto({
    required this.minContextSlot,
    required this.transactions,
    required this.publicKey,
    required this.identityUri,
    required this.identityName,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  final int? minContextSlot;

  final List<Uint8List?> transactions;

  final Uint8List publicKey;

  @override
  final String? identityName;

  @override
  final String? identityUri;

  @override
  final String? iconRelativeUri;

  @override
  final String cluster;

  @override
  final Uint8List authorizationScope;
}

class SignaturesResultDto {
  SignaturesResultDto({
    required this.signatures,
    required this.error,
    required this.validSignatures,
  });

  final List<Uint8List?>? signatures;
  final MobileWalletAdapterServerException? error;
  final List<bool?>? validSignatures;
}

@FlutterApi()
abstract class ApiFlutter {
  void onScenarioReady(int id);
  void onScenarioServingClients(int id);
  void onScenarioServingComplete(int id);
  void onScenarioComplete(int id);
  void onScenarioError(int id);
  void onScenarioTeardownComplete(int id);

  @async
  AuthorizeResultDto? authorize(AuthorizeRequestDto request, int id);

  @async
  bool reauthorize(ReauthorizeRequestDto request, int id);

  @async
  SignedPayloadsResultDto? signTransactions(
    SignTransactionsRequestDto request,
    int id,
  );

  @async
  SignedPayloadsResultDto? signMessages(
    SignMessagesRequestDto request,
    int id,
  );

  @async
  SignaturesResultDto? signAndSendTransactions(
    SignAndSendTransactionsRequestDto request,
    int id,
  );
}

@HostApi()
abstract class ApiHost {
  void start(int id);
  void close(int id);
}
