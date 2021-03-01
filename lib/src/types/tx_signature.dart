import 'package:solana_dart/src/types/common_tx.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';

class TxSignature extends CommonTx {
  TxSignature._(dynamic value) : _signature = value;
  TxSignature.fromJsonRpcResponseString(jsonRpcResponseString)
      : this._(JsonRpcResponseObject.getResult(jsonRpcResponseString));

  final String _signature;

  String toString() => _signature;
}
