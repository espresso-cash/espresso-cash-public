import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'token_amount.g.dart';

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
