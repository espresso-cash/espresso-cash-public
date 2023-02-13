// ignore_for_file: deprecated_member_use

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry/sentry.dart';
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
  required Ed25519HDKeyPair platform,
  required Ed25519HDPublicKey mint,
  required SolanaClient client,
  required Commitment commitment,
}) async {
  final signatures = await client.rpcClient.getSignaturesForAddress(
    address.toBase58(),
    limit: 2,
    commitment: commitment,
  );

  if (signatures.length != 1) {
    await Sentry.captureMessage(
      'Invalid number of signatures for escrow account',
      level: SentryLevel.warning,
      withScope: (scope) => scope.setContexts('data', {
        'length': signatures.length,
        'address': address.toBase58(),
        'commitment': commitment.value,
      }),
    );

    return null;
  }

  final signature = signatures.first;

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
    publicKey: platform.publicKey,
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
