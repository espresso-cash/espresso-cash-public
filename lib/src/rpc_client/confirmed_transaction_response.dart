part of 'rpc_client.dart';

@JsonSerializable(createToJson: false)
class ConfirmedTransactionResponse extends JsonRpcResponse<TransactionResult?> {
  ConfirmedTransactionResponse(TransactionResult? result)
      : super(result: result);

  factory ConfirmedTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmedTransactionResponseFromJson(json);
}
