// ignore_for_file: cast_nullable_to_non_nullable, avoid-future-ignore, avoid-type-casts

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana_mobile_client/solana_mobile_client.dart';
import 'package:solana_mobile_client_example/config.dart';

part 'client.freezed.dart';

// ignore: avoid-cubits, just an example
class ClientBloc extends Cubit<ClientState> {
  ClientBloc() : super(const ClientState()) {
    _initializeClient();
  }

  late SolanaClient _solanaClient;

  void _initializeClient() {
    final rpcUrl = state.isMainnet ? mainnetRpcUrl : testnetRpcUrl;
    final websocketUrl = state.isMainnet ? mainnetWsUrl : testnetWsUrl;
    _solanaClient = SolanaClient(rpcUrl: Uri.parse(rpcUrl), websocketUrl: Uri.parse(websocketUrl));
  }

  void updateNetwork({required bool isMainnet}) {
    if (state.isMainnet == isMainnet) return;
    _initializeClient();
    emit(ClientState(isMainnet: isMainnet));
  }

  Future<bool> isWalletAvailable() => LocalAssociationScenario.isAvailable();

  Future<void> requestCapabilities() async {
    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    final result = await client.getCapabilities();
    await session.close();

    emit(state.copyWith(capabilities: result));
  }

  Future<void> authorize() async {
    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    await _doAuthorize(client);
    await session.close();
  }

  Future<void> reauthorize() async {
    final authToken = state.authorizationResult?.authToken;
    if (authToken == null) return;

    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    await _doReauthorize(client);
    await session.close();
  }

  Future<void> deauthorize() async {
    final authToken = state.authorizationResult?.authToken;
    if (authToken == null) return;

    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    await client.deauthorize(authToken: authToken);
    await session.close();

    emit(state.copyWith(authorizationResult: null));
  }

  Future<void> requestAirdrop() async {
    final publicKey = state.authorizationResult?.publicKey;
    if (publicKey == null) return;

    if (state.isRequestingAirdrop) return;

    emit(state.copyWith(isRequestingAirdrop: true));

    try {
      await _solanaClient.requestAirdrop(
        address: Ed25519HDPublicKey(publicKey),
        lamports: lamportsPerSol,
      );
    } finally {
      emit(state.copyWith(isRequestingAirdrop: false));
    }
  }

  Future<void> signMessages(int number) async {
    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    if (await _doReauthorize(client)) {
      final signer = state.publicKey as Ed25519HDPublicKey;

      final addresses = [signer.bytes].map(Uint8List.fromList).toList();
      final messages =
          _generateMessages(number: number, signer: signer)
              .map((e) => e.compile(recentBlockhash: '', feePayer: signer).toByteArray().toList())
              .map(Uint8List.fromList)
              .toList();

      await client.signMessages(messages: messages, addresses: addresses);
    }
    await session.close();
  }

  Future<void> signAndSendTransactions(int number) async {
    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    if (await _doReauthorize(client)) {
      final signer = state.publicKey as Ed25519HDPublicKey;

      final blockhash = await _solanaClient.rpcClient.getLatestBlockhash().then(
        (it) => it.value.blockhash,
      );
      final txs =
          _generateTransactions(
            number: number,
            signer: signer,
            blockhash: blockhash,
          ).map((e) => e.toByteArray().toList()).map(Uint8List.fromList).toList();

      await client.signAndSendTransactions(transactions: txs);
    }
    await session.close();
  }

  Future<void> signTransactions(int number) async {
    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    if (await _doReauthorize(client)) {
      await _doGenerateAndSignTransactions(client, number);
    }
    await session.close();
  }

  Future<void> authorizeAndSignTransactions() async {
    final session = await LocalAssociationScenario.create();

    session.startActivityForResult(null).ignore();

    final client = await session.start();
    if (await _doAuthorize(client)) {
      await _doGenerateAndSignTransactions(client, 1);
    }
    await session.close();
  }

  Future<void> _doGenerateAndSignTransactions(MobileWalletAdapterClient client, int number) async {
    final signer = state.publicKey as Ed25519HDPublicKey;

    final blockhash = await _solanaClient.rpcClient.getLatestBlockhash().then(
      (it) => it.value.blockhash,
    );
    final txs =
        _generateTransactions(
          number: number,
          signer: signer,
          blockhash: blockhash,
        ).map((e) => e.toByteArray().toList()).map(Uint8List.fromList).toList();

    await client.signTransactions(transactions: txs);
  }

  Future<bool> _doAuthorize(MobileWalletAdapterClient client) async {
    final result = await client.authorize(
      identityUri: Uri.parse('https://solana.com'),
      iconUri: Uri.parse('favicon.ico'),
      identityName: 'Solana',
      cluster: state.isMainnet ? mainnetCluster : testnetCluster,
    );

    emit(state.copyWith(authorizationResult: result));

    return result != null;
  }

  Future<bool> _doReauthorize(MobileWalletAdapterClient client) async {
    final authToken = state.authorizationResult?.authToken;
    if (authToken == null) return false;

    final result = await client.reauthorize(
      identityUri: Uri.parse('https://solana.com'),
      iconUri: Uri.parse('favicon.ico'),
      identityName: 'Solana',
      authToken: authToken,
    );

    emit(state.copyWith(authorizationResult: result));

    return result != null;
  }
}

@freezed
sealed class ClientState with _$ClientState {
  const factory ClientState({
    GetCapabilitiesResult? capabilities,
    AuthorizationResult? authorizationResult,
    @Default(false) bool isRequestingAirdrop,
    @Default(false) bool isMainnet,
  }) = _ClientState;

  const ClientState._();

  bool get isAuthorized => authorizationResult != null;

  bool get canRequestAirdrop => isAuthorized && !isRequestingAirdrop;

  Ed25519HDPublicKey? get publicKey {
    final publicKey = authorizationResult?.publicKey;
    if (publicKey == null) return null;

    return Ed25519HDPublicKey(publicKey);
  }

  String? get address => publicKey?.toBase58();
}

List<SignedTx> _generateTransactions({
  required int number,
  required Ed25519HDPublicKey signer,
  required String blockhash,
}) {
  final instructions = List.generate(
    number,
    (index) => MemoInstruction(signers: [signer], memo: 'Memo #$index'),
  );
  final signature = Signature(List.filled(64, 0), publicKey: signer);

  return instructions
      .map(Message.only)
      .map(
        (e) => SignedTx(
          compiledMessage: e.compile(recentBlockhash: blockhash, feePayer: signer),
          signatures: [signature],
        ),
      )
      .toList();
}

List<Message> _generateMessages({required int number, required Ed25519HDPublicKey signer}) =>
    List.generate(
      number,
      (index) => MemoInstruction(signers: [signer], memo: 'Memo #$index'),
    ).map(Message.only).toList();
