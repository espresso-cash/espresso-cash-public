import 'package:json_annotation/json_annotation.dart';
import 'package:solana_dart/src/types/tx_meta.dart';

part 'transaction.g.dart';

@JsonSerializable(createToJson: false)
class TransactionResponse {
  TransactionResponse({
    this.meta,
    this.slot,
    this.blockTime,
    this.instructions,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  final TxMeta meta;
  final int slot;
  final int blockTime;
  final Iterable<TxInstruction> instructions;
}

abstract class TxInstruction {
  factory TxInstruction.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'transfer':
        return TransferTx.fromJson(
          json['parsed']['info'] as Map<String, dynamic>,
        );
      default:
        throw FallThroughError();
    }
  }
}

@JsonSerializable(createToJson: false)
class TransferTx implements TxInstruction {
  TransferTx({
    this.source,
    this.destination,
    this.lamports,
  });

  factory TransferTx.fromJson(Map<String, dynamic> json) =>
      _$TransferTxFromJson(json);

  final String source;
  final String destination;
  final int lamports;
}
