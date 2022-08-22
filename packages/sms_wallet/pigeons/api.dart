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
}

@HostApi()
abstract class ApiHost {
  void start(int id);
  void close(int id);
}
