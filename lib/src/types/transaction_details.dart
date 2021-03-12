import 'package:solana_dart/src/types/base_tx.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';
import 'package:solana_dart/src/types/tx_meta.dart';

class TransactionDetails {
  TransactionDetails({
    this.slot,
    this.meta,
    this.blockTime,
    this.transaction,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) {
    return TransactionDetails(
      slot: json['slot'],
      meta: TxMeta.fromJson(json['meta']),
      transaction: BaseTx.fromJson({
        ...json['transaction'],
        "timestamp": json['blockTime'],
      }),
    );
  }

  factory TransactionDetails.fromJsonRpcResponseString(
          String jsonRpcResponseString) =>
      TransactionDetails.fromJson(
        JsonRpcResponseObject.getResult(jsonRpcResponseString),
      );

  final int slot;
  final BaseTx transaction;
  final int blockTime;
  final TxMeta meta;

  String toString() {
    return '$transaction';
  }
}
