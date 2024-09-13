// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moneygram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MoneygramChallengeSignRequestDtoImpl
    _$$MoneygramChallengeSignRequestDtoImplFromJson(
            Map<String, dynamic> json) =>
        _$MoneygramChallengeSignRequestDtoImpl(
          signedTx: json['signedTx'] as String,
        );

Map<String, dynamic> _$$MoneygramChallengeSignRequestDtoImplToJson(
        _$MoneygramChallengeSignRequestDtoImpl instance) =>
    <String, dynamic>{
      'signedTx': instance.signedTx,
    };

_$MoneygramChallengeSignResponseDtoImpl
    _$$MoneygramChallengeSignResponseDtoImplFromJson(
            Map<String, dynamic> json) =>
        _$MoneygramChallengeSignResponseDtoImpl(
          signedTx: json['signedTx'] as String,
        );

Map<String, dynamic> _$$MoneygramChallengeSignResponseDtoImplToJson(
        _$MoneygramChallengeSignResponseDtoImpl instance) =>
    <String, dynamic>{
      'signedTx': instance.signedTx,
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

_$MoneygramFeeRequestDtoImpl _$$MoneygramFeeRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$MoneygramFeeRequestDtoImpl(
      amount: json['amount'] as String,
      type: $enumDecode(_$RampTypeDtoEnumMap, json['type']),
    );

Map<String, dynamic> _$$MoneygramFeeRequestDtoImplToJson(
        _$MoneygramFeeRequestDtoImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'type': _$RampTypeDtoEnumMap[instance.type]!,
    };

const _$RampTypeDtoEnumMap = {
  RampTypeDto.onRamp: 'onRamp',
  RampTypeDto.offRamp: 'offRamp',
};

_$MoneygramFeeResponseDtoImpl _$$MoneygramFeeResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$MoneygramFeeResponseDtoImpl(
      totalAmount: json['totalAmount'] as String,
      bridgeFee: json['bridgeFee'] as String,
      moneygramFee: json['moneygramFee'] as String,
    );

Map<String, dynamic> _$$MoneygramFeeResponseDtoImplToJson(
        _$MoneygramFeeResponseDtoImpl instance) =>
    <String, dynamic>{
      'totalAmount': instance.totalAmount,
      'bridgeFee': instance.bridgeFee,
      'moneygramFee': instance.moneygramFee,
    };

_$FundXlmRequestDtoImpl _$$FundXlmRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$FundXlmRequestDtoImpl(
      accountId: json['accountId'] as String,
    );

Map<String, dynamic> _$$FundXlmRequestDtoImplToJson(
        _$FundXlmRequestDtoImpl instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
    };
