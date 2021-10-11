import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'balance.g.dart';

@JsonSerializable(createToJson: false)
class BalanceResponse extends JsonRpcResponse<ValueResponse<int>> {
  BalanceResponse(ValueResponse<int> result) : super(result: result);

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseFromJson(json);
}
