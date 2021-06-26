part of 'decoder.dart';

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
