import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';
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

  Future<void> signPayloadsSimulateSign() async {
    throw UnimplementedError();
  }

  Future<void> signPayloadsDeclined() async {
    final request =
        state.whenOrNull(remote: (r) => r)?.whenOrNull(signPayloads: (r) => r);

    if (request == null) return;

    _completer?.complete(const SignedPayloadResult.requestDeclined());
  }

  Future<void> signPayloadsSimulateAuthTokenInvalid() async {
    final request =
        state.whenOrNull(remote: (r) => r)?.whenOrNull(signPayloads: (r) => r);

    if (request == null) return;

    _completer?.complete(const SignedPayloadResult.authorizationNotValid());
  }

  Future<void> signPayloadsSimulateInvalidPayloads() async {
    final request =
        state.whenOrNull(remote: (r) => r)?.whenOrNull(signPayloads: (r) => r);

    if (request == null) return;

    final valid = List.generate(request.payloads.length, (i) => i != 0);
    _completer?.complete(SignedPayloadResult.invalidPayloads(valid: valid));
  }

  Future<void> signPayloadsSimulateTooManyPayloads() async {
    final request =
        state.whenOrNull(remote: (r) => r)?.whenOrNull(signPayloads: (r) => r);

    if (request == null) return;

    _completer?.complete(const SignedPayloadResult.tooManyPayloads());
  }

  Future<void> signAndSendTransactionsSimulateSign() async {
    throw UnimplementedError();
  }

  Future<void> signAndSendTransactionsDeclined() async {
    final request = state
        .whenOrNull(remote: (r) => r)
        ?.whenOrNull(signTransactionsForSending: (r) => r);

    if (request == null) return;

    _completer?.complete(const SignaturesResult.requestDeclined());
  }

  Future<void> signAndSendTransactionsSimulateAuthTokenInvalid() async {
    final request = state
        .whenOrNull(remote: (r) => r)
        ?.whenOrNull(signTransactionsForSending: (r) => r);

    if (request == null) return;

    _completer?.complete(const SignaturesResult.authorizationNotValid());
  }

  Future<void> signAndSendTransactionsSimulateInvalidPayloads() async {
    final request = state
        .whenOrNull(remote: (r) => r)
        ?.whenOrNull(signTransactionsForSending: (r) => r);

    if (request == null) return;

    final valid = List.generate(request.transactions.length, (i) => i != 0);
    _completer?.complete(SignaturesResult.invalidPayloads(valid: valid));
  }

  Future<void> signAndSendTransactionsSimulateTooManyPayloads() async {
    final request = state
        .whenOrNull(remote: (r) => r)
        ?.whenOrNull(signTransactionsForSending: (r) => r);

    if (request == null) return;

    _completer?.complete(const SignaturesResult.tooManyPayloads());
  }

  Future<void> signAndSendTransactionsSubmitted() async {
    throw UnimplementedError();
  }

  Future<void> signAndSendTransactionsNotSubmitted() async {
    throw UnimplementedError();
  }

  Future<void> signAndSendTransactionsSend() async {
    throw UnimplementedError();
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
  Future<SignedPayloadResult?> onSignTransactionsRequest(
    SignTransactionsRequest request,
  ) async {
    _cancelCurrentRequest();

    emit(
      MobileWalletState.remote(RemoteRequest.signPayloads(request: request)),
    );

    return _createNewRequest<SignedPayloadResult>();
  }

  @override
  Future<SignedPayloadResult?> onSignMessagesRequest(
    SignMessagesRequest request,
  ) {
    _cancelCurrentRequest();

    emit(
      MobileWalletState.remote(RemoteRequest.signPayloads(request: request)),
    );

    return _createNewRequest<SignedPayloadResult>();
  }

  @override
  Future<SignaturesResult?> onSignAndSendTransactionsRequest(
    SignAndSendTransactionsRequest request,
  ) {
    _cancelCurrentRequest();

    emit(
      MobileWalletState.remote(
        RemoteRequest.signTransactionsForSending(request: request),
      ),
    );

    return _createNewRequest<SignaturesResult>();
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
