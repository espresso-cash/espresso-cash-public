// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_supply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenSupply _$TokenSupplyFromJson(Map<String, dynamic> json) {
  return TokenSupply(
    amount: json['amount'] as String,
    decimals: json['decimals'] as int,
  );
}

TokenSupplyResult _$TokenSupplyResultFromJson(Map<String, dynamic> json) {
  return TokenSupplyResult(
    context: json['context'],
    value: TokenSupply.fromJson(json['value'] as Map<String, dynamic>),
  );
}

GetTokenSupplyResponse _$GetTokenSupplyResponseFromJson(
    Map<String, dynamic> json) {
  return GetTokenSupplyResponse(
    TokenSupplyResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}
