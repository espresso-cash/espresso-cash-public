import 'dart:async';

import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

class SolanaClient {
  SolanaClient({
    required Uri rpcUrl,
    required Uri websocketUrl,
    Duration timeout = const Duration(seconds: 30),
  }) : rpcClient = RpcClient(rpcUrl.toString(), timeout: timeout),
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
    SignatureCallback onSigned = ignoreOnSigned,
    required Commitment commitment,
  }) async {
    final bh = await rpcClient.getLatestBlockhash(commitment: commitment).value;
    final tx = await signTransaction(bh, message, signers);
    await onSigned(tx.signatures.first.toBase58());

    final signature = await rpcClient.sendTransaction(tx.encode(), preflightCommitment: commitment);

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
    Duration? pingInterval,
  }) async {
    final subscriptionClient = createSubscriptionClient(
      pingInterval: pingInterval,
      connectTimeout: timeout,
    );

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

  SubscriptionClient createSubscriptionClient({Duration? pingInterval, Duration? connectTimeout}) =>
      SubscriptionClient(_websocketUrl, pingInterval: pingInterval, connectTimeout: connectTimeout);
}

typedef SignatureCallback = FutureOr<void> Function(TransactionId transactionId);

void ignoreOnSigned(TransactionId _) {}
