import 'dart:convert';

class TxSignature {
  TxSignature._(dynamic value) : _signature = value['result'];
  TxSignature.fromJsonRpcResponseString(jsonRpcResponseString)
      : this._(
          json.decode(jsonRpcResponseString),
        );
  String toString() => _signature;
  final String _signature;
}
