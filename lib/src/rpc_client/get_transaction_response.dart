part of 'rpc_client.dart';

@JsonSerializable(createToJson: false)
class _GetTransactionResponse extends JsonRpcResponse<TransactionResponse> {
  _GetTransactionResponse(TransactionResponse result) : super(result: result);

  factory _GetTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$_GetTransactionResponseFromJson(json);
}
