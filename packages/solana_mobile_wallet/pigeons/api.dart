// ignore_for_file: avoid_positional_boolean_parameters

import 'package:pigeon/pigeon.dart';

class AuthorizeRequestDto {
  const AuthorizeRequestDto({
    required this.identityName,
    required this.identityUri,
    required this.iconUri,
  });

  final String? identityName;
  final String? identityUri;
  final String? iconUri;
}

class AuthorizeResultDto {
  const AuthorizeResultDto({
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
  const BaseVerifiableIdentityRequestDto({
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
  const ReauthorizeRequestDto({
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
  const SignPayloadsRequestDto({
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
  const SignedPayloadsResultDto({
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
  notSubmitted,
}

class RequestDeclinedException {
  const RequestDeclinedException();
}

class InvalidPayloadsException {
  const InvalidPayloadsException({required this.valid});

  final List<bool?> valid;
}

class TooManyPayloadsException {
  const TooManyPayloadsException();
}

class AuthorizationNotValidException {
  const AuthorizationNotValidException();
}

class SignTransactionsRequestDto implements SignPayloadsRequestDto {
  const SignTransactionsRequestDto({
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
  const SignMessagesRequestDto({
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
  const SignAndSendTransactionsRequestDto({
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
  const SignaturesResultDto({
    required this.signatures,
    required this.error,
    required this.validSignatures,
  });

  final List<Uint8List?>? signatures;
  final MobileWalletAdapterServerException? error;
  final List<bool?>? validSignatures;
}

class DeauthorizeEventDto implements BaseVerifiableIdentityRequestDto {
  const DeauthorizeEventDto({
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

class WalletConfigDto {
  const WalletConfigDto({
    required this.supportsSignAndSendTransactions,
    required this.maxTransactionsPerSigningRequest,
    required this.maxMessagesPerSigningRequest,
    required this.supportedTransactionVersions,
    required this.noConnectionWarningTimeoutInMs,
  });

  final bool supportsSignAndSendTransactions;
  final int maxTransactionsPerSigningRequest;
  final int maxMessagesPerSigningRequest;
  final List<String?> supportedTransactionVersions;
  final int noConnectionWarningTimeoutInMs;
}

class AuthIssuerConfigDto {
  const AuthIssuerConfigDto({
    required this.name,
    required this.authorizationValidityInMs,
    required this.maxOutstandingTokensPerIdentility,
    required this.reauthorizationNopDurationInMs,
    required this.reauthorizationValidityInMs,
  });

  final String name;
  final int maxOutstandingTokensPerIdentility;
  final int authorizationValidityInMs;
  final int reauthorizationValidityInMs;
  final int reauthorizationNopDurationInMs;
}

@FlutterApi()
abstract class ApiFlutter {
  const ApiFlutter();
  void onScenarioReady(int id);
  void onScenarioServingClients(int id);
  void onScenarioServingComplete(int id);
  void onScenarioComplete(int id);
  void onScenarioError(int id);
  void onScenarioTeardownComplete(int id);
  void onLowPowerAndNoConnection(int id);

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

  @async
  void deauthorize(
    DeauthorizeEventDto event,
    int id,
  );

  void onNewIntent(bool isInitialIntent);
}

@HostApi()
abstract class ApiHost {
  const ApiHost();
  void start(int id);
  void close(int id);

  @async
  Uint8List? createScenario(
    int id,
    WalletConfigDto walletConfig,
    AuthIssuerConfigDto authIssuerConfig,
  );
}
