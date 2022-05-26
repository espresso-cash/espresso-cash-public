// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_amount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenAmount _$TokenAmountFromJson(Map<String, dynamic> json) => TokenAmount(
      amount: json['amount'] as String,
      decimals: json['decimals'] as int,
      uiAmountString: json['uiAmountString'] as String?,
    );

Map<String, dynamic> _$TokenAmountToJson(TokenAmount instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'decimals': instance.decimals,
      'uiAmountString': instance.uiAmountString,
    };
