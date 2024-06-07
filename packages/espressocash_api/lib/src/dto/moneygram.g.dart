// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moneygram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MoneygramDepositRequestDtoImpl _$$MoneygramDepositRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$MoneygramDepositRequestDtoImpl(
      signedTx: json['signedTx'] as String,
      account: json['account'] as String,
      amount: json['amount'] as String,
      lang: json['lang'] as String,
    );

Map<String, dynamic> _$$MoneygramDepositRequestDtoImplToJson(
        _$MoneygramDepositRequestDtoImpl instance) =>
    <String, dynamic>{
      'signedTx': instance.signedTx,
      'account': instance.account,
      'amount': instance.amount,
      'lang': instance.lang,
    };

_$MoneygramDepositResponseDtoImpl _$$MoneygramDepositResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$MoneygramDepositResponseDtoImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$$MoneygramDepositResponseDtoImplToJson(
        _$MoneygramDepositResponseDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'token': instance.token,
    };
