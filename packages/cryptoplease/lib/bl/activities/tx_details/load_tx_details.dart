import 'package:collection/collection.dart';
import 'package:cryptoplease/bl/activities/solana_transaction.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

Future<SolanaTransactionDetails?> loadTxDetails(
  TransactionId id, {
  required RpcClient client,
}) async {
  final response = await client.getTransaction(
    id,
    encoding: Encoding.jsonParsed,
  );

  if (response == null) return null;

  return _splTxTransformer(response) ??
      _solTxTransformer(response) ??
      _fallbackTransformer(response);
}

SolanaTransactionDetails? _solTxTransformer(TransactionDetails response) {
  final transaction = response.transaction;
  final instruction = transaction.message.instructions
      .whereType<ParsedInstructionSystem>()
      .firstWhereOrNull(
        (ParsedInstructionSystem tx) => tx.parsed.maybeMap(
          transfer: (_) => true,
          transferChecked: (_) => true,
          orElse: () => false,
        ),
      );

  if (instruction == null) return null;

  return instruction.parsed.maybeMap(
    transfer: (transfer) => SolanaTransactionDetails.fromSystemTransfer(
      instruction: transfer,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: transaction.signatures.first,
      meta: response.meta,
    ),
    transferChecked: (transfer) =>
        SolanaTransactionDetails.fromSystemTransferChecked(
      instruction: transfer,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: transaction.signatures.first,
      meta: response.meta,
    ),
    orElse: () => null,
  );
}

SolanaTransactionDetails? _splTxTransformer(TransactionDetails response) {
  final transaction = response.transaction;
  final instruction = transaction.message.instructions
      .whereType<ParsedInstructionSplToken>()
      .firstWhereOrNull(
        (ParsedInstructionSplToken tx) => tx.parsed.maybeMap(
          transfer: (_) => true,
          transferChecked: (_) => true,
          orElse: () => false,
        ),
      );

  if (instruction == null) return null;

  return instruction.parsed.maybeMap(
    transfer: (transfer) => SolanaTransactionDetails.fromSplTokenTransfer(
      instruction: transfer,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: transaction.signatures.first,
      meta: response.meta,
    ),
    transferChecked: (transfer) =>
        SolanaTransactionDetails.fromSplTokenTransferChecked(
      instruction: transfer,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: transaction.signatures.first,
      meta: response.meta,
    ),
    orElse: () => null,
  );
}

SolanaTransactionDetails _fallbackTransformer(TransactionDetails response) =>
    SolanaTransactionDetails.generic(
      state: response.meta?.err == null ? TxState.success : TxState.failure,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: response.transaction.signatures.first,
    );

DateTime? _blockTimeToDateTime(int? blockTime) {
  if (blockTime == null) return null;

  return DateTime.fromMillisecondsSinceEpoch(1000 * blockTime);
}
