// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_amount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenAmount _$TokenAmountFromJson(Map<String, dynamic> json) {
  return TokenAmount(
    decimals: json['decimals'] as int,
    amount: json['amount'] as String,
    uiAmountString: json['uiAmountString'] as String,
  );
}

TokenBalanceResponse _$TokenBalanceResponseFromJson(Map<String, dynamic> json) {
  return TokenBalanceResponse(
    ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
        (value) => TokenAmount.fromJson(value as Map<String, dynamic>)),
  );
}
