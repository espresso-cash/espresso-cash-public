import 'package:meta/meta.dart';
import 'package:solana_dart/src/types/base_tx.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';
import 'package:solana_dart/src/types/tx_meta.dart';

class TransactionDetails {
  TransactionDetails({
    @required this.slot,
    @required this.meta,
    @required this.blockTime,
    @required this.transaction,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      TransactionDetails(
        slot: json['slot'] as int,
        meta: TxMeta.fromJson(json['meta'] as Map<String, dynamic>),
        transaction: BaseTx.fromJson(<String, dynamic>{
          ...json['transaction'],
          'timestamp': json['blockTime'],
        }),
        blockTime: json['blockTime'],
      );

  factory TransactionDetails.fromJsonRpcResponseString(
    String jsonRpcResponseString,
  ) =>
      TransactionDetails.fromJson(
        JsonRpcResponseObject.getResult(jsonRpcResponseString),
      );

  final int slot;
  final BaseTx transaction;
  final int blockTime;
  final TxMeta meta;

  @override
  String toString() => '$transaction';
}
