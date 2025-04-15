import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';

import '../../../config.dart';
import '../../accounts/auth_scope.dart';
import '../data/repository.dart';
import '../models/notification.dart';
import '../models/remote_request.dart';

@Singleton(scope: authScope)
class ScenarioHandler implements ScenarioCallbacks {
  ScenarioHandler(this._repository) {
    Api.instance.setup(
      walletConfig: const MobileWalletAdapterConfig(
        supportsSignAndSendTransactions: true,
        maxTransactionsPerSigningRequest: maxPayloadsPerSigningRequest,
        maxMessagesPerSigningRequest: maxPayloadsPerSigningRequest,
        supportedTransactionVersions: ['legacy'],
      ),
      issuerConfig: const AuthIssuerConfig(name: 'Espresso Cash'),
      callbacks: this,
    );
  }

  final MobileWalletRepository _repository;
  Scenario? _scenario;

  @override
  Future<AuthorizeResult?> onAuthorizeRequest(AuthorizeRequest request) {
    final remoteRequest = RemoteRequest.authorizeDapp(request: request);

    return _repository.notifyApp(MobileWalletNotification.request(remoteRequest));
  }

  @override
  Future<bool> onReauthorizeRequest(ReauthorizeRequest request) async => true;

  @override
  Future<SignaturesResult?> onSignAndSendTransactionsRequest(
    SignAndSendTransactionsRequest request,
  ) {
    final remoteRequest = RemoteRequest.signTransactionsForSending(request: request);

    return _repository.notifyApp(MobileWalletNotification.request(remoteRequest));
  }

  @override
  Future<SignedPayloadResult?> onSignMessagesRequest(SignMessagesRequest request) {
    final remoteRequest = RemoteRequest.signPayloads(request: request);

    return _repository.notifyApp(MobileWalletNotification.request(remoteRequest));
  }

  @override
  Future<SignedPayloadResult?> onSignTransactionsRequest(SignTransactionsRequest request) {
    final remoteRequest = RemoteRequest.signPayloads(request: request);

    return _repository.notifyApp(MobileWalletNotification.request(remoteRequest));
  }

  @override
  void onScenarioServingComplete() {
    _scenario?.close();
  }

  @override
  void onScenarioComplete() {}

  @override
  void onScenarioError() {}

  @override
  void onScenarioReady(Scenario scenario) {
    _scenario = scenario;
    _repository.notifyApp<void>(const MobileWalletNotification.initialized());
  }

  @override
  void onScenarioServingClients() {}

  @override
  void onScenarioTeardownComplete() {
    _repository.notifyApp<void>(const MobileWalletNotification.sessionTerminated());
  }

  @override
  Future<void> onDeauthorizeEvent(DeauthorizeEvent event) =>
      _repository.notifyApp<void>(const MobileWalletNotification.deauthorized());

  @override
  void onLowPowerAndNoConnection() {}
}
