import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';
import 'package:solana/src/rpc_client/transaction_response.dart';

part 'get_transaction_response.g.dart';

@JsonSerializable(createToJson: false)
class GetTransactionResponse extends JsonRpcResponse<TransactionResponse> {
  GetTransactionResponse(TransactionResponse result) : super(result: result);

  factory GetTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionResponseFromJson(json);
}
