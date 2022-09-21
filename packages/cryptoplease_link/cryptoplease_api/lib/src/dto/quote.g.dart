// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Quote _$$_QuoteFromJson(Map<String, dynamic> json) => _$_Quote(
      quoteAmount: (json['quoteAmount'] as num).toDouble(),
      feeAmount: (json['feeAmount'] as num).toDouble(),
      networkFeeAmount: (json['networkFeeAmount'] as num).toDouble(),
      quotePrice: (json['quotePrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$_QuoteToJson(_$_Quote instance) => <String, dynamic>{
      'quoteAmount': instance.quoteAmount,
      'feeAmount': instance.feeAmount,
      'networkFeeAmount': instance.networkFeeAmount,
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
