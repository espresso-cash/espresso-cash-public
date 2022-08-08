import 'package:pigeon/pigeon.dart';

class AuthorizeRequest {
  AuthorizeRequest({
    required this.identityName,
    required this.identityUri,
    required this.iconUri,
  });

  final String? identityName;
  final String? identityUri;
  final String? iconUri;
}

class AuthorizeResult {
  AuthorizeResult({
    required this.publicKey,
    required this.accountLabel,
    required this.walletUriBase,
    required this.scope,
  });

  final Uint8List publicKey;
  final String accountLabel;
  final String? walletUriBase;
  final Uint8List scope;
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
  AuthorizeResult? authorize(AuthorizeRequest request, int id);
}

@HostApi()
abstract class ApiHost {
  void start(int id);
  void close(int id);
}
