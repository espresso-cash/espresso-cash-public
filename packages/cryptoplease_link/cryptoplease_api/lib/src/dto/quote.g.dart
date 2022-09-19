// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuoteResponseDto _$$_QuoteResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_QuoteResponseDto(
      quoteAmount: (json['quoteAmount'] as num).toDouble(),
      feeAmount: (json['feeAmount'] as num).toDouble(),
      networkFeeAmount: (json['networkFeeAmount'] as num).toDouble(),
      minAmount: json['minAmount'] as int,
      quotePrice: (json['quotePrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$_QuoteResponseDtoToJson(_$_QuoteResponseDto instance) =>
    <String, dynamic>{
      'quoteAmount': instance.quoteAmount,
      'feeAmount': instance.feeAmount,
      'networkFeeAmount': instance.networkFeeAmount,
      'minAmount': instance.minAmount,
      'quotePrice': instance.quotePrice,
    };

_$_QuoteRequestDto _$$_QuoteRequestDtoFromJson(Map<String, dynamic> json) =>
    _$_QuoteRequestDto(
      tokenSymbol: json['tokenSymbol'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$_QuoteRequestDtoToJson(_$_QuoteRequestDto instance) =>
    <String, dynamic>{
      'tokenSymbol': instance.tokenSymbol,
      'value': instance.value,
    };
