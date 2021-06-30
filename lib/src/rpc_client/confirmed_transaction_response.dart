import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';
import 'package:solana/src/rpc_client/transaction_response.dart';

part 'confirmed_transaction_response.g.dart';

@JsonSerializable(createToJson: false)
class ConfirmedTransactionResponse
    extends JsonRpcResponse<TransactionResponse?> {
  ConfirmedTransactionResponse(TransactionResponse? result)
      : super(result: result);

  factory ConfirmedTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmedTransactionResponseFromJson(json);
}
