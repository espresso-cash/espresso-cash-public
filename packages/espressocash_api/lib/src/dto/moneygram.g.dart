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

_$SwapToStellarRequestDtoImpl _$$SwapToStellarRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$SwapToStellarRequestDtoImpl(
      solanaSenderAddress: json['solanaSenderAddress'] as String,
      stellarReceiverAddress: json['stellarReceiverAddress'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$$SwapToStellarRequestDtoImplToJson(
        _$SwapToStellarRequestDtoImpl instance) =>
    <String, dynamic>{
      'solanaSenderAddress': instance.solanaSenderAddress,
      'stellarReceiverAddress': instance.stellarReceiverAddress,
      'amount': instance.amount,
    };

_$SwapToSolanaRequestDtoImpl _$$SwapToSolanaRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$SwapToSolanaRequestDtoImpl(
      stellarSenderAddress: json['stellarSenderAddress'] as String,
      solanaReceiverAddress: json['solanaReceiverAddress'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$$SwapToSolanaRequestDtoImplToJson(
        _$SwapToSolanaRequestDtoImpl instance) =>
    <String, dynamic>{
      'stellarSenderAddress': instance.stellarSenderAddress,
      'solanaReceiverAddress': instance.solanaReceiverAddress,
      'amount': instance.amount,
    };

_$MoneygramSwapResponseDtoImpl _$$MoneygramSwapResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$MoneygramSwapResponseDtoImpl(
      encodedTx: json['encodedTx'] as String,
    );

Map<String, dynamic> _$$MoneygramSwapResponseDtoImplToJson(
        _$MoneygramSwapResponseDtoImpl instance) =>
    <String, dynamic>{
      'encodedTx': instance.encodedTx,
    };
