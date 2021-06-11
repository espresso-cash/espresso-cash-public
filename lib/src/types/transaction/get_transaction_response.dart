import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/json_rpc_response_object.dart';
import 'package:solana/src/types/transaction/transaction_result.dart';

part 'get_transaction_response.g.dart';

@JsonSerializable(createToJson: false)
class GetTransactionResponse extends JsonRpcResponse<TransactionResult> {
  GetTransactionResponse(TransactionResult result) : super(result: result);

  factory GetTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionResponseFromJson(json);
}
