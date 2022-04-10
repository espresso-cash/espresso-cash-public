import 'dart:async';

import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

class SolanaClient {
  SolanaClient({
    required Uri rpcUrl,
    required Uri websocketUrl,
    Duration timeout = const Duration(seconds: 30),
  })  : rpcClient = RpcClient(rpcUrl.toString(), timeout: timeout),
        _timeout = timeout,
        _websocketUrl = websocketUrl;

  final RpcClient rpcClient;
  final Uri _websocketUrl;
  final Duration _timeout;

  /// Signs, sends and confirms a transaction.
  ///
  /// Use [onSigned] callback to do some action *after* transaction is signed,
  /// but *before* it is sent.
  Future<TransactionId> sendAndConfirmTransaction({
    required Message message,
    required List<Ed25519HDKeyPair> signers,
    required SignatureCallback onSigned,
    required Commitment commitment,
  }) async {
    final tx = await signTransaction(
      await rpcClient.getRecentBlockhash(),
      message,
      signers,
    );
    await onSigned(tx.signatures.first.toBase58());

    final signature = await rpcClient.sendTransaction(
      tx.encode(),
      commitment: commitment,
    );

    await waitForSignatureStatus(signature, status: commitment);

    return signature;
  }

  /// Waits for transation with [signature] to reach [status].
  /// Throws exception if transaction failed.
  ///
  /// If [timeout] is null then timeout from [SolanaClient] is used.
  Future<void> waitForSignatureStatus(
    String signature, {
    required ConfirmationStatus status,
    Duration? timeout,
  }) async {
    final subscriptionClient = _createSubscriptionClient();

    try {
      await subscriptionClient.waitForSignatureStatus(
        signature,
        status: status,
        timeout: timeout ?? _timeout,
      );
    } finally {
      subscriptionClient.close();
    }
  }

  SubscriptionClient _createSubscriptionClient() =>
      SubscriptionClient(_websocketUrl);
}

typedef SignatureCallback = Future<void> Function(TransactionId transactionId);

Future<void> ignoreOnSigned(TransactionId _) async {}
