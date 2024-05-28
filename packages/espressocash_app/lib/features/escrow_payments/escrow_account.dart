// ignore_for_file: deprecated_member_use

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import 'escrow_exception.dart';

part 'escrow_account.freezed.dart';

@freezed
class EscrowAccount with _$EscrowAccount {
  const factory EscrowAccount({
    required Ed25519HDPublicKey address,
    required Ed25519HDPublicKey mint,
    required int amount,
  }) = _EscrowAccount;
}

Future<EscrowAccount?> validateEscrow({
  required Ed25519HDPublicKey address,
  required Ed25519HDPublicKey mint,
  required SolanaClient client,
  required Commitment commitment,
}) async {
  final usdcAta = await findAssociatedTokenAddress(owner: address, mint: mint);

  final doesAccountExist = await client.rpcClient
          .getAccountInfo(
            usdcAta.toBase58(),
            encoding: Encoding.base64,
            commitment: commitment,
          )
          .value !=
      null;

  if (doesAccountExist) {
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

  final signatures = await client.rpcClient.getSignaturesForAddress(
    address.toBase58(),
    limit: 100,
    commitment: commitment,
  );

  if (signatures.isEmpty) {
    throw const EscrowException.notReady();
  }

  if (signatures.length == 2) {
    throw const EscrowException.alreadyWithdrawn();
  }

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

      throw const EscrowException.invalidEscrow();
    }
  }

  throw const EscrowException.other();
}
