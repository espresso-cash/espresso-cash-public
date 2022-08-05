import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:sms_wallet/src/auth_issuer_config.dart';
import 'package:sms_wallet/src/sms_wallet_platform.dart';
import 'package:sms_wallet/src/wallet_config.dart';

class Scenario {
  Scenario._({
    required this.associationPublicKey,
    required this.callbacks,
    required this.id,
  }) : _channel = MethodChannel('com.solana.sms.scenario#$id') {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

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

    return Scenario._(
      associationPublicKey: associationPublicKey,
      callbacks: callbacks,
      id: id,
    );
  }

  static int _nextId = 1;

  final MethodChannel _channel;
  final int id;

  final Uint8List associationPublicKey;
  final ScenarioCallbacks callbacks;

  void start() {
    _channel.invokeMethod('start');
  }

  void close() {
    _channel.invokeMethod('close');
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onScenarioReady':
        callbacks.onScenarioReady();
        break;
      case 'onScenarioServingClients':
        callbacks.onScenarioServingClients();
        break;
      case 'onScenarioServingComplete':
        callbacks.onScenarioServingComplete();
        break;
      case 'onScenarioComplete':
        callbacks.onScenarioComplete();
        break;
      case 'onScenarioError':
        callbacks.onScenarioError();
        break;
      case 'onScenarioTeardownComplete':
        callbacks.onScenarioTeardownComplete();
        break;
      default:
        throw UnimplementedError(call.method);
    }
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
  // void onAuthorizeRequest(AuthorizeRequest request);
  // void onReauthorizeRequest(ReauthorizeRequest request);
  // void onSignTransactionsRequest(SignTransactionsRequest request);
  // void onSignMessagesRequest(SignMessagesRequest request);
  // void onSignAndSendTransactionsRequest(SignAndSendTransactionsRequest request);
}
