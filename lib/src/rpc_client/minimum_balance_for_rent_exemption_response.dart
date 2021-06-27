part of 'rpc_client.dart';

@JsonSerializable(createToJson: false)
class MinimumBalanceForRentExemptionResponse extends JsonRpcResponse<int> {
  MinimumBalanceForRentExemptionResponse(int result) : super(result: result);

  factory MinimumBalanceForRentExemptionResponse.fromJson(
          Map<String, dynamic> json) =>
      _$MinimumBalanceForRentExemptionResponseFromJson(json);
}
