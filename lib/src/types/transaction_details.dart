import 'package:json_annotation/json_annotation.dart';
import 'package:solana_dart/src/types/base_tx.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';
import 'package:solana_dart/src/types/tx_meta.dart';

part 'transaction_details.g.dart';

@JsonSerializable(createToJson: false)
class TransactionDetails {
  TransactionDetails({
    this.slot,
    this.meta,
    this.blockTime,
    this.transaction,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsFromJson({
        ...json,
        "transaction": <String, dynamic>{
          // Copy the rest of the transaction
          ...json['transaction'],
          // Add this field so that the transaction
          // can determine the timestamp
          "timestamp": json['blockTime']
        }
      });

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
