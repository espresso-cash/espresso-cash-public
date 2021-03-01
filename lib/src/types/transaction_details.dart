import 'package:solana_dart/src/types/common_tx.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';
import 'package:solana_dart/src/types/tx_meta.dart';
import 'package:solana_dart/src/types/tx_parser.dart';

class TransactionDetails {
  TransactionDetails._(dynamic value)
      : slot = value['slot'],
        transactions = TxParser.parse(
          value['transaction'],
          timestamp: value['blockTime'],
        ),
        blockTime = value['blockTime'],
        meta = TxMeta(value['meta']);

  TransactionDetails.fromJsonRpcResponseString(String jsonRpcResponseString)
      : this._(JsonRpcResponseObject.getResult(jsonRpcResponseString));

  final int slot;
  final List<CommonTx> transactions;
  final int blockTime;
  final TxMeta meta;

  String toString() {
    return '$transactions';
  }
}
