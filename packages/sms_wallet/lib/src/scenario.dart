import 'dart:typed_data';

import 'package:sms_wallet/src/api.dart';
import 'package:sms_wallet/src/auth_issuer_config.dart';
import 'package:sms_wallet/src/requests/authorize.dart';
import 'package:sms_wallet/src/requests/reauthorize.dart';
import 'package:sms_wallet/src/sms_wallet_platform.dart';
import 'package:sms_wallet/src/wallet_config.dart';

class Scenario {
  Scenario._({
    required this.associationPublicKey,
    required this.callbacks,
    required this.id,
  });

  static Future<Scenario?> create({
    required MobileWalletAdapterConfig walletConfig,
    required AuthIssuerConfig issuerConfig,
    required ScenarioCallbacks callbacks,
  }) async {
    final id = _nextId++;
    final associationPublicKey =
        await SmsWalletPlatform.instance.createScenario(
      walletConfig: walletConfig,
      issuerConfig: issuerConfig,
      id: id,
    );
    if (associationPublicKey == null) {
      return null;
    }

    final scenario = Scenario._(
      associationPublicKey: associationPublicKey,
      callbacks: callbacks,
      id: id,
    );

    Api.instance.register(scenario);

    return scenario;
  }

  static int _nextId = 1;

  final int id;

  final Uint8List associationPublicKey;
  final ScenarioCallbacks callbacks;
  final _host = ApiHost();

  void start() {
    _host.start(id);
  }

  void close() {
    _host.close(id);
  }
}

abstract class ScenarioCallbacks {
  // Scenario state callbacks
  void onScenarioReady();
  void onScenarioServingClients();
  void onScenarioServingComplete();
  void onScenarioComplete();
  void onScenarioError();
  void onScenarioTeardownComplete();

  // Request callbacks
  Future<AuthorizeResult?> onAuthorizeRequest(AuthorizeRequest request);
  Future<bool> onReauthorizeRequest(ReauthorizeRequest request);
  // void onSignTransactionsRequest(SignTransactionsRequest request);
  // void onSignMessagesRequest(SignMessagesRequest request);
  // void onSignAndSendTransactionsRequest(SignAndSendTransactionsRequest request);
}

class Api implements ApiFlutter {
  Api._() {
    ApiFlutter.setup(this);
  }

  static final _instance = Api._();

  static Api get instance => _instance;

  static final _scenarios = <int, Scenario>{};

  void register(Scenario scenario) {
    _scenarios[scenario.id] = scenario;
  }

  void unregister(int id) {
    _scenarios.remove(id);
  }

  @override
  Future<AuthorizeResultDto?> authorize(
    AuthorizeRequestDto request,
    int id,
  ) async {
    final r = AuthorizeRequest(
      identityName: request.identityName,
      identityUri: Uri.tryParse(request.identityUri ?? ''),
      iconUri: Uri.tryParse(request.iconUri ?? ''),
    );
    final result = await _scenarios[id]?.callbacks.onAuthorizeRequest(r);
    if (result == null) return null;

    return AuthorizeResultDto(
      publicKey: result.publicKey,
      accountLabel: result.accountLabel,
      walletUriBase: result.walletUriBase?.toString(),
      scope: result.scope,
    );
  }

  @override
  Future<bool> reauthorize(ReauthorizeRequestDto request, int id) async {
    final r = ReauthorizeRequest(
      identityName: request.identityName,
      identityUri: Uri.tryParse(request.identityUri ?? ''),
      iconRelativeUri: Uri.tryParse(request.iconRelativeUri ?? ''),
      cluster: request.cluster,
      authorizationScope: request.authorizationScope,
    );

    final result = await _scenarios[id]?.callbacks.onReauthorizeRequest(r);

    return result ?? false;
  }

  @override
  void onScenarioReady(int id) {
    _scenarios[id]?.callbacks.onScenarioReady();
  }

  @override
  void onScenarioComplete(int id) {
    _scenarios[id]?.callbacks.onScenarioComplete();
  }

  @override
  void onScenarioError(int id) {
    _scenarios[id]?.callbacks.onScenarioError();
  }

  @override
  void onScenarioServingClients(int id) {
    _scenarios[id]?.callbacks.onScenarioServingClients();
  }

  @override
  void onScenarioServingComplete(int id) {
    _scenarios[id]?.callbacks.onScenarioServingComplete();
  }

  @override
  void onScenarioTeardownComplete(int id) {
    _scenarios[id]?.callbacks.onScenarioTeardownComplete();
    unregister(id);
  }
}
