import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

part 'solana_transaction.freezed.dart';

@freezed
class SolanaTransactionDetails with _$SolanaTransactionDetails {
  const factory SolanaTransactionDetails.generic({
    required String hash,
    required DateTime? blockTime,
    required TxState state,
  }) = GenericSolanaTransaction;

  const factory SolanaTransactionDetails.transfer({
    required String hash,
    required DateTime? blockTime,
    required Ed25519HDPublicKey senderAddress,
    required Ed25519HDPublicKey recipientAddress,
    required int amount,
    required TxState state,
  }) = TransferSolanaTransaction;

  factory SolanaTransactionDetails.fromSystemTransfer({
    required ParsedSystemTransferInstruction instruction,
    required String hash,
    required DateTime? blockTime,
    required Meta? meta,
  }) {
    final transferTx = instruction.info;
    final amount = transferTx.lamports;

    return SolanaTransactionDetails.transfer(
      hash: hash,
      senderAddress: Ed25519HDPublicKey.fromBase58(transferTx.source),
      recipientAddress: Ed25519HDPublicKey.fromBase58(transferTx.destination),
      blockTime: blockTime,
      amount: amount,
      state: meta?.err == null ? TxState.success : TxState.failure,
    );
  }

  factory SolanaTransactionDetails.fromSystemTransferChecked({
    required ParsedSystemTransferCheckedInstruction instruction,
    required String hash,
    required DateTime? blockTime,
    required Meta? meta,
  }) {
    final transferTx = instruction.info;
    final amount = transferTx.lamports;

    return SolanaTransactionDetails.transfer(
      hash: hash,
      senderAddress: Ed25519HDPublicKey.fromBase58(transferTx.source),
      recipientAddress: Ed25519HDPublicKey.fromBase58(transferTx.destination),
      blockTime: blockTime,
      amount: amount,
      state: meta?.err == null ? TxState.success : TxState.failure,
    );
  }

  factory SolanaTransactionDetails.fromSplTokenTransfer({
    required ParsedSplTokenTransferInstruction instruction,
    required String hash,
    required DateTime? blockTime,
    required Meta? meta,
  }) {
    final transferTx = instruction.info;
    final amount = int.parse(transferTx.amount);

    return SolanaTransactionDetails.transfer(
      hash: hash,
      senderAddress: Ed25519HDPublicKey.fromBase58(transferTx.source),
      recipientAddress: Ed25519HDPublicKey.fromBase58(transferTx.destination),
      blockTime: blockTime,
      amount: amount,
      state: meta?.err == null ? TxState.success : TxState.failure,
    );
  }

  factory SolanaTransactionDetails.fromSplTokenTransferChecked({
    required ParsedSplTokenTransferCheckedInstruction instruction,
    required String hash,
    required DateTime? blockTime,
    required Meta? meta,
  }) {
    final transferTx = instruction.info;
    final amount = int.parse(transferTx.tokenAmount.amount);

    return SolanaTransactionDetails.transfer(
      hash: hash,
      senderAddress: Ed25519HDPublicKey.fromBase58(transferTx.source),
      recipientAddress: Ed25519HDPublicKey.fromBase58(transferTx.destination),
      blockTime: blockTime,
      amount: amount,
      state: meta?.err == null ? TxState.success : TxState.failure,
    );
  }

  const SolanaTransactionDetails._();
}

@freezed
class SolanaTransaction with _$SolanaTransaction {
  const factory SolanaTransaction({
    required TransactionId id,
    required DateTime blockTime,
    required Ed25519HDKeyPair account,
    required TxState state,
    String? base64Data,
  }) = _SolanaTransaction;
}

abstract class TransactionReaderRepository {
  Stream<Iterable<SolanaTransaction>> watchTransactions();
}

enum TxState { success, failure }
