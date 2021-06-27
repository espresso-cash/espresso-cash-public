part of 'rpc_client.dart';

/// Response of the [`sendTransaction`][send transaction] rpc method.
///
/// [send transaction]: https://docs.solana.com/developing/clients/jsonrpc-api#sendtransaction
class TransactionSignature {
  TransactionSignature(this._signature);

  factory TransactionSignature.fromJson(String json) =>
      TransactionSignature(json);

  @override
  String toString() => _signature;

  final String _signature;
}

@JsonSerializable(createToJson: false)
class _SignatureResponse extends JsonRpcResponse<TransactionSignature> {
  _SignatureResponse(TransactionSignature result) : super(result: result);

  factory _SignatureResponse.fromJson(Map<String, dynamic> json) =>
      _$_SignatureResponseFromJson(json);
}
