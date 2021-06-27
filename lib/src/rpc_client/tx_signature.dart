part of 'rpc_client.dart';

class TxSignature {
  TxSignature(this._signature);

  factory TxSignature.fromJson(String json) => TxSignature(json);

  @override
  String toString() => _signature;

  final String _signature;
}

@JsonSerializable(createToJson: false)
class TxSignatureResponse extends JsonRpcResponse<TxSignature> {
  TxSignatureResponse(TxSignature result) : super(result: result);

  factory TxSignatureResponse.fromJson(Map<String, dynamic> json) =>
      _$TxSignatureResponseFromJson(json);
}
