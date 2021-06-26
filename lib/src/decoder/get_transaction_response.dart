part of 'decoder.dart';

@JsonSerializable(createToJson: false)
class GetTransactionResponse extends JsonRpcResponse<TransactionResult> {
  GetTransactionResponse(TransactionResult result) : super(result: result);

  factory GetTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionResponseFromJson(json);
}
