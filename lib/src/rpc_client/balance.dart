part of 'rpc_client.dart';

@JsonSerializable(createToJson: false)
class _BalanceResponse extends JsonRpcResponse<ValueResponse<int>> {
  _BalanceResponse(ValueResponse<int> result) : super(result: result);

  factory _BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$_BalanceResponseFromJson(json);
}
