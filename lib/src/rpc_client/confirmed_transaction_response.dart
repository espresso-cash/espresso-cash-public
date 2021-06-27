part of 'rpc_client.dart';

@JsonSerializable(createToJson: false)
class _ConfirmedTransactionResponse
    extends JsonRpcResponse<TransactionResponse?> {
  _ConfirmedTransactionResponse(TransactionResponse? result)
      : super(result: result);

  factory _ConfirmedTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$_ConfirmedTransactionResponseFromJson(json);
}
