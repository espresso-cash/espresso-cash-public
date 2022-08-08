import 'dart:typed_data';

import 'package:sms_wallet/src/api.dart';
import 'package:sms_wallet/src/auth_issuer_config.dart';
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
  // void onReauthorizeRequest(ReauthorizeRequest request);
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
  Future<AuthorizeResult?> authorize(AuthorizeRequest request, int id) async =>
      _scenarios[id]?.callbacks.onAuthorizeRequest(request);

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
