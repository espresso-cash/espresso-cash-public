import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';

part 'bloc.freezed.dart';
part 'state.dart';

// ignore: avoid-cubits, just an example
class MobileWalletBloc extends Cubit<MobileWalletState>
    implements ScenarioCallbacks {
  MobileWalletBloc(this._keyPair) : super(const MobileWalletState.none()) {
    Api.instance.setup(
      walletConfig: const MobileWalletAdapterConfig(
        supportsSignAndSendTransactions: true,
        maxTransactionsPerSigningRequest: 10,
        maxMessagesPerSigningRequest: 10,
        supportedTransactionVersions: ['legacy'],
      ),
      issuerConfig: const AuthIssuerConfig(name: 'example_wallet'),
      callbacks: this,
    );
  }

  Scenario? _scenario;
  Completer<Object?>? _completer;

  final Ed25519HDKeyPair _keyPair;
  late final _client = RpcClient('https://api.testnet.solana.com');

  @override
  void onScenarioReady(Scenario scenario) {
    _scenario = scenario;
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
          publicKey: Uint8List.fromList(_keyPair.publicKey.bytes),
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
    final request =
        state.whenOrNull(remote: (r) => r)?.whenOrNull(signPayloads: (r) => r);

    if (request == null) return;

    final payloads = request.payloads;

    final transactions = await Future.wait(
      request.map(
        transactions: (request) => payloads.map(
          (e) async {
            final tx = SignedTx.fromBytes(e);

            return SignedTx(
              compiledMessage: tx.compiledMessage,
              signatures: [
                await _keyPair.sign(tx.compiledMessage.toByteArray()),
              ],
            ).toByteArray().toList();
          },
        ),
        messages: (request) => payloads.map(
          (e) async => e + await _keyPair.sign(e).then((value) => value.bytes),
        ),
      ),
    );

    final result = SignedPayloadResult(
      signedPayloads: transactions.map(Uint8List.fromList).toList(),
    );

    _completer?.complete(result);
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
    final request = state
        .whenOrNull(remote: (r) => r)
        ?.whenOrNull(signTransactionsForSending: (r) => r);

    if (request == null) return;

    final transactions = await Future.wait(
      request.transactions.map(
        (e) async {
          final tx = SignedTx.fromBytes(e);

          return SignedTx(
            compiledMessage: tx.compiledMessage,
            signatures: [await _keyPair.sign(tx.compiledMessage.toByteArray())],
          );
        },
      ),
    );

    emit(
      MobileWalletState.remote(
        RemoteRequest.sendTransactions(
          request: request,
          signatures: transactions
              .map((e) => e.signatures.first.bytes)
              .map(Uint8List.fromList)
              .toList(),
          signedTransactions: transactions
              .map((e) => e.toByteArray().toList())
              .map(Uint8List.fromList)
              .toList(),
        ),
      ),
    );
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
    final request = state
        .whenOrNull(remote: (r) => r)
        ?.mapOrNull(sendTransactions: (r) => r);

    if (request == null) return;

    final result = SignaturesResult(signatures: request.signatures);

    _completer?.complete(result);
  }

  Future<void> signAndSendTransactionsNotSubmitted() async {
    final request = state
        .whenOrNull(remote: (r) => r)
        ?.mapOrNull(sendTransactions: (r) => r);

    if (request == null) return;

    final result =
        SignaturesResult.notSubmitted(signatures: request.signatures);

    _completer?.complete(result);
  }

  Future<void> signAndSendTransactionsSend() async {
    final request = state
        .whenOrNull(remote: (r) => r)
        ?.mapOrNull(sendTransactions: (r) => r);

    if (request == null) return;

    final results = await Future.wait(
      request.signedTransactions.map(base64.encode).map(
            (e) => _client
                .sendTransaction(e)
                .then((_) => true, onError: (_) => false),
          ),
    );

    final result = results.any((e) => !e)
        ? SignaturesResult.invalidPayloads(valid: results)
        : SignaturesResult(signatures: request.signatures);

    _completer?.complete(result);
  }

  void _cancelCurrentRequest() {
    final completer = _completer;
    if (completer != null && !completer.isCompleted) {
      completer.complete(null);
    }
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
  void onScenarioServingClients() {}

  @override
  void onLowPowerAndNoConnection() {}

  @override
  void onScenarioServingComplete() {
    _scenario?.close();
  }

  @override
  void onScenarioTeardownComplete() {
    emit(const MobileWalletState.sessionTerminated());
  }

  @override
  Future<void> onDeauthorizeEvent(DeauthorizeEvent event) async {
    emit(const MobileWalletState.sessionTerminated());
  }
}
