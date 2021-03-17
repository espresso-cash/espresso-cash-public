import 'package:json_annotation/json_annotation.dart';
import 'package:solana_dart/src/types/json_rpc_response_object.dart';

part 'tx_signature.g.dart';

class TxSignature {
  TxSignature(this._signature);

  final String _signature;

  @override
  String toString() => _signature;
}

@JsonSerializable(createToJson: false)
class TxSignatureResponse extends JsonRpcResponse<String> {
  TxSignatureResponse(String result) : super(result: result);

  factory TxSignatureResponse.fromJson(Map<String, dynamic> json) =>
      _$TxSignatureResponseFromJson(json);
}
