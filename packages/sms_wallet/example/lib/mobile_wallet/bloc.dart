import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sms_wallet/sms_wallet.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';

part 'state.dart';

class MobileWalletBloc extends Cubit<MobileWalletState>
    implements ScenarioCallbacks {
  MobileWalletBloc() : super(const MobileWalletState.none()) {
    _init();
  }

  Scenario? _scenario;
  Completer<Object?>? _completer;

  Future<void> _init() async {
    _scenario = await Scenario.create(
      walletConfig: const MobileWalletAdapterConfig(
        supportsSignAndSendTransactions: true,
        maxTransactionsPerSigningRequest: 10,
        maxMessagesPerSigningRequest: 10,
      ),
      issuerConfig: const AuthIssuerConfig(name: 'example_wallet'),
      callbacks: this,
    );

    _scenario?.start();
  }

  Future<void> authorizeDapp({
    required bool isAuthorized,
    required String scopeTag,
    required String? qualifier,
  }) async {
    final request =
        state.whenOrNull(remote: (r) => r)?.whenOrNull(authorizeDapp: (r) => r);

    if (request == null) return;

    if (isAuthorized) {
      _completer?.complete(
        AuthorizeResult(
          publicKey: Uint8List.fromList(
            (await Ed25519HDKeyPair.random()).publicKey.bytes,
          ),
          accountLabel: 'FlutterWallet',
          walletUriBase: null,
          scope: Uint8List.fromList(
            utf8.encode([scopeTag, qualifier].whereType<String>().join(',')),
          ),
        ),
      );
    } else {
      _completer?.complete(null);
    }
  }

  void _cancelCurrentRequest() {
    _completer?.complete(null);
    _completer = null;
  }

  Future<T?> _createNewRequest<T>() {
    final c = Completer<T?>();
    _completer = c;

    return c.future;
  }

  @override
  Future<AuthorizeResult?> onAuthorizeRequest(AuthorizeRequest request) {
    _cancelCurrentRequest();

    emit(
      MobileWalletState.remote(RemoteRequest.authorizeDapp(request: request)),
    );

    return _createNewRequest<AuthorizeResult>();
  }

  @override
  Future<bool> onReauthorizeRequest(ReauthorizeRequest request) async {
    _cancelCurrentRequest();

    return true;
  }

  @override
  void onScenarioComplete() {}

  @override
  void onScenarioError() {}

  @override
  void onScenarioReady() {}

  @override
  void onScenarioServingClients() {}

  @override
  void onScenarioServingComplete() {
    _scenario?.close();
  }

  @override
  void onScenarioTeardownComplete() {
    emit(const MobileWalletState.sessionTerminated());
  }
}
