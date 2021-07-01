import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/rpc_client/json_rpc_response_object.dart';

part 'token_supply.g.dart';

@JsonSerializable(createToJson: false)
class TokenSupply {
  const TokenSupply({
    required this.amount,
    required this.decimals,
  });

  factory TokenSupply.fromJson(Map<String, dynamic> json) =>
      _$TokenSupplyFromJson(json);

  final String amount;
  final int decimals;
}

@JsonSerializable(createToJson: false)
class TokenSupplyResult {
  const TokenSupplyResult({
    required this.context,
    required this.value,
  });

  factory TokenSupplyResult.fromJson(Map<String, dynamic> json) =>
      _$TokenSupplyResultFromJson(json);

  final dynamic context;
  final TokenSupply value;
}

@JsonSerializable(createToJson: false)
class GetTokenSupplyResponse extends JsonRpcResponse<TokenSupplyResult> {
  GetTokenSupplyResponse(TokenSupplyResult result) : super(result: result);

  factory GetTokenSupplyResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTokenSupplyResponseFromJson(json);
}
