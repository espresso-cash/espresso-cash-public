import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/json_rpc_response_object.dart';
import 'package:solana/src/types/transaction/transaction_result.dart';

part 'confirmed_transaction_response.g.dart';

@JsonSerializable(createToJson: false)
class ConfirmedTransactionResponse extends JsonRpcResponse<TransactionResult?> {
  ConfirmedTransactionResponse(TransactionResult? result)
      : super(result: result);

  factory ConfirmedTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmedTransactionResponseFromJson(json);
}
