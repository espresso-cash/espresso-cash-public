part of 'spl_token.dart';

@JsonSerializable(createToJson: false)
class TokenAmount {
  TokenAmount({
    required this.decimals,
    required this.amount,
    required this.uiAmountString,
  });

  factory TokenAmount.fromJson(Map<String, dynamic> json) =>
      _$TokenAmountFromJson(json);

  final int decimals;
  final String amount;
  final String uiAmountString;
}

@JsonSerializable(createToJson: false)
class TokenBalanceResponse extends JsonRpcResponse<ValueResponse<TokenAmount>> {
  TokenBalanceResponse(ValueResponse<TokenAmount> result)
      : super(result: result);

  factory TokenBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenBalanceResponseFromJson(json);
}
