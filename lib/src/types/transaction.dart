import 'package:json_annotation/json_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';
import 'package:solana/src/types/blockhash.dart';
import 'package:solana/src/types/json_rpc_response_object.dart';
import 'package:solana/src/types/tx_meta.dart';
import 'package:solana/src/util/solana_int_encoder.dart';

part 'transaction.g.dart';

@JsonSerializable(createToJson: false)
class ConfirmedTransactionResponse
    extends JsonRpcResponse<ConfirmedTransaction?> {
  ConfirmedTransactionResponse(ConfirmedTransaction? result)
      : super(result: result);

  factory ConfirmedTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmedTransactionResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class ConfirmedTransaction {
  ConfirmedTransaction({
    this.meta,
    required this.slot,
    required this.blockTime,
    required this.transaction,
  });

  factory ConfirmedTransaction.fromJson(Map<String, dynamic> json) =>
      _$ConfirmedTransactionFromJson(json);

  final TxMeta? meta;
  final int slot;
  final int blockTime;
  final Transaction transaction;
}

@JsonSerializable(createToJson: false)
class Transaction {
  Transaction({required this.message});

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  final TxMessage message;
}

@JsonSerializable(createToJson: false)
class TxMessage {
  TxMessage({this.instructions});

  factory TxMessage.fromJson(Map<String, dynamic> json) =>
      _$TxMessageFromJson(json);

  final Iterable<TxInstruction>? instructions;
}

abstract class TxInstruction {
  factory TxInstruction.fromJson(Map<String, dynamic> json) {
    switch (json['parsed']['type'] as String) {
      case 'transfer':
        return TransferTx.fromJson(
          json['parsed']['info'] as Map<String, dynamic>,
        );
      default:
        return const UnknownTx();
    }
  }
}

class UnknownTx implements TxInstruction {
  const UnknownTx();
}

@JsonSerializable(createToJson: false)
class TransferTx implements TxInstruction {
  TransferTx({
    required this.source,
    required this.destination,
    required this.lamports,
  });

  factory TransferTx.fromJson(Map<String, dynamic> json) =>
      _$TransferTxFromJson(json);

  final String source;
  final String destination;
  final int lamports;

  Message compile(Blockhash recentBlockhash) {
    final instruction = Instruction(
      programIdIndex: 2,
      accountIndices: CompactArray.fromList([0, 1]),
      data: CompactArray.fromList(
        [
          ...2.toSolanaBytes(32),
          ...lamports.toSolanaBytes(64),
        ],
      ),
    );

    final message = Message(
      header: MessageHeader(1, 0, 1),
      accounts: CompactArray.fromList([
        Address.from(source),
        Address.from(destination),
        Address.from(solanaSystemProgramID),
      ]),
      recentBlockhash: recentBlockhash.blockhash,
      instructions: CompactArray.fromList([instruction]),
    );
    return message;
  }
}
