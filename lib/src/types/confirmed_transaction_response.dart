import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/json_rpc_response_object.dart';
import 'package:solana/src/types/transaction/get_transaction_result.dart';

part 'confirmed_transaction_response.g.dart';

@JsonSerializable(createToJson: false)
class ConfirmedTransactionResponse
    extends JsonRpcResponse<GetTransactionResult?> {
  ConfirmedTransactionResponse(GetTransactionResult? result)
      : super(result: result);

  factory ConfirmedTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmedTransactionResponseFromJson(json);
}
