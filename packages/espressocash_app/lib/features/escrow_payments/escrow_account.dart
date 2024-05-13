// ignore_for_file: deprecated_member_use

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/base58.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'escrow_account.freezed.dart';

@freezed
class EscrowAccount with _$EscrowAccount {
  const factory EscrowAccount({
    required Ed25519HDPublicKey address,
    required Ed25519HDPublicKey mint,
    required int amount,
  }) = _EscrowAccount;
}

@useResult
Future<EscrowAccount?> tryFetchEscrow({
  required Ed25519HDPublicKey address,
  required Ed25519HDPublicKey platform,
  required Ed25519HDPublicKey mint,
  required SolanaClient client,
  required Commitment commitment,
}) async {
  final signatures = await client.rpcClient.getSignaturesForAddress(
    address.toBase58(),
    limit: 100,
    commitment: commitment,
  );

  if (signatures.length != 1) {
    final escrowTransactions = await client.rpcClient
        .getMultipleTransactions(
          signatures,
          commitment: commitment,
          encoding: Encoding.base64,
          maxSupportedTransactionVersion: 0,
        )
        .then(
          (transactions) => transactions.where((details) {
            final tx = details.transaction;
            if (tx is! RawTransaction) return false;

            return SignedTx.fromBytes(tx.data)
                .signatures
                .map((e) => e.publicKey)
                .contains(address);
          }),
        );

    if (escrowTransactions.length != 1) {
      await Sentry.captureMessage(
        'Invalid number of signatures for escrow account',
        level: SentryLevel.warning,
        withScope: (scope) => scope.setContexts('data', {
          'length': escrowTransactions.length,
          'address': address.toBase58(),
          'commitment': commitment.value,
        }),
      );

      return null;
    }
  }

  final signature = signatures.last;

  if (signature.err != null) {
    await Sentry.captureMessage(
      'Signature had an error',
      level: SentryLevel.warning,
      withScope: (scope) => scope.setContexts('error', signature.err),
    );

    return null;
  }

  final tx = await client.rpcClient.getTransaction(
    signature.signature,
    commitment: commitment,
    encoding: Encoding.base64,
  );

  if (tx == null) {
    await Sentry.captureMessage(
      'Transaction not found',
      level: SentryLevel.warning,
      withScope: (scope) => scope.setContexts('signature', signature.signature),
    );

    return null;
  }

  final signedTx =
      SignedTx.fromBytes(ByteArray((tx.transaction as RawTransaction).data));

  final compiled = signedTx.compiledMessage;

  final isValid = await verifySignature(
    message: compiled.toByteArray().toList(),
    signature: base58decode(signature.signature),
    publicKey: platform,
  );

  if (!isValid) {
    await Sentry.captureMessage(
      'Invalid signature',
      level: SentryLevel.warning,
      withScope: (scope) => scope.setContexts('signature', signature.signature),
    );

    return null;
  }

  final amount = await client.getTokenBalance(
    owner: address,
    mint: mint,
    commitment: commitment,
  );

  return EscrowAccount(
    address: address,
    mint: mint,
    amount: int.parse(amount.amount),
  );
}
