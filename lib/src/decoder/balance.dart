part of 'decoder.dart';

@JsonSerializable(createToJson: false)
class BalanceResponse extends JsonRpcResponse<ValueResponse<int>> {
  BalanceResponse(ValueResponse<int> result) : super(result: result);

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseFromJson(json);
}
