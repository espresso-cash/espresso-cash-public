import 'package:solana_dart/src/types/json_rpc_response_object.dart';

class TxSignature {
  TxSignature(this._signature);

  factory TxSignature.fromJson(dynamic value) => TxSignature(value);

  factory TxSignature.fromJsonRpcResponseString(jsonRpcResponseString) =>
      TxSignature.fromJson(
          JsonRpcResponseObject.getResult(jsonRpcResponseString));

  final String _signature;

  String toString() => _signature;
}
