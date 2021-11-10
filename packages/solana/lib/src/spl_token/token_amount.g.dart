// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_amount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenAmount _$TokenAmountFromJson(Map<String, dynamic> json) => TokenAmount(
      decimals: json['decimals'] as int,
      amount: json['amount'] as String,
      uiAmountString: json['uiAmountString'] as String,
    );

Map<String, dynamic> _$TokenAmountToJson(TokenAmount instance) =>
    <String, dynamic>{
      'decimals': instance.decimals,
      'amount': instance.amount,
      'uiAmountString': instance.uiAmountString,
    };

TokenBalanceResponse _$TokenBalanceResponseFromJson(
        Map<String, dynamic> json) =>
    TokenBalanceResponse(
      ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
          (value) => TokenAmount.fromJson(value as Map<String, dynamic>)),
    );
