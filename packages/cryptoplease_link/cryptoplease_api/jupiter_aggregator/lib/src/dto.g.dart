// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuoteRequestDto _$$_QuoteRequestDtoFromJson(Map<String, dynamic> json) =>
    _$_QuoteRequestDto(
      inputMint: json['inputMint'] as String,
      outputMint: json['outputMint'] as String,
      amount: json['amount'] as int,
      swapMode: $enumDecodeNullable(_$SwapModeEnumMap, json['swapMode']) ??
          SwapMode.exactIn,
      slippage: (json['slippage'] as num?)?.toDouble(),
      feeBps: (json['feeBps'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_QuoteRequestDtoToJson(_$_QuoteRequestDto instance) {
  final val = <String, dynamic>{
    'inputMint': instance.inputMint,
    'outputMint': instance.outputMint,
    'amount': instance.amount,
    'swapMode': _$SwapModeEnumMap[instance.swapMode]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('slippage', instance.slippage);
  writeNotNull('feeBps', instance.feeBps);
  return val;
}

const _$SwapModeEnumMap = {
  SwapMode.exactIn: 'ExactIn',
  SwapMode.exactOut: 'ExactOut',
};

_$_QuoteResponseDto _$$_QuoteResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_QuoteResponseDto(
      routes: (json['data'] as List<dynamic>)
          .map((e) => JupiterRoute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_QuoteResponseDtoToJson(_$_QuoteResponseDto instance) =>
    <String, dynamic>{
      'data': instance.routes,
    };

_$_SwapRequestDto _$$_SwapRequestDtoFromJson(Map<String, dynamic> json) =>
    _$_SwapRequestDto(
      userPublicKey: json['userPublicKey'] as String,
      route: JupiterRoute.fromJson(json['route'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SwapRequestDtoToJson(_$_SwapRequestDto instance) =>
    <String, dynamic>{
      'userPublicKey': instance.userPublicKey,
      'route': instance.route,
    };
