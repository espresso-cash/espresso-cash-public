part of 'rpc_client.dart';

@JsonSerializable(createToJson: false)
class _MinimumBalanceForRentExemptionResponse extends JsonRpcResponse<int> {
  _MinimumBalanceForRentExemptionResponse(int result) : super(result: result);

  factory _MinimumBalanceForRentExemptionResponse.fromJson(
          Map<String, dynamic> json) =>
      _$_MinimumBalanceForRentExemptionResponseFromJson(json);
}
