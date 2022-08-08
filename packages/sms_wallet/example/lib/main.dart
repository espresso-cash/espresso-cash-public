import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_wallet/sms_wallet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Scenario? _scenario;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _scenario = await Scenario.create(
      walletConfig: const MobileWalletAdapterConfig(
        supportsSignAndSendTransactions: true,
        maxTransactionsPerSigningRequest: 10,
        maxMessagesPerSigningRequest: 10,
      ),
      issuerConfig: const AuthIssuerConfig(name: 'example_wallet'),
      callbacks: _Callbacks(() => _scenario),
    );

    _scenario?.start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('Running...'),
        ),
      ),
    );
  }
}

class _Callbacks implements ScenarioCallbacks {
  _Callbacks(this._scenario);

  final Scenario? Function() _scenario;

  @override
  void onScenarioComplete() {
    print('onScenarioComplete');
  }

  @override
  void onScenarioError() {
    print('onScenarioError');
  }

  @override
  void onScenarioReady() {
    print('onScenarioReady');
  }

  @override
  void onScenarioServingClients() {
    print('onScenarioServingClients');
  }

  @override
  void onScenarioServingComplete() {
    print('onScenarioServingComplete');
    _scenario()?.close();
  }

  @override
  void onScenarioTeardownComplete() {
    print('onScenarioTeardownComplete');
    SystemNavigator.pop();
  }

  @override
  Future<AuthorizeResult?> onAuthorizeRequest(AuthorizeRequest request) {
    // TODO: implement onAuthorizeRequest
    throw UnimplementedError();
  }
}
