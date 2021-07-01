import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'minimum_balance_for_rent_exemption_response.g.dart';

@JsonSerializable(createToJson: false)
class MinimumBalanceForRentExemptionResponse extends JsonRpcResponse<int> {
  MinimumBalanceForRentExemptionResponse(int result) : super(result: result);

  factory MinimumBalanceForRentExemptionResponse.fromJson(
          Map<String, dynamic> json) =>
      _$MinimumBalanceForRentExemptionResponseFromJson(json);
}
