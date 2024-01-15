// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blockhash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blockhash _$BlockhashFromJson(Map<String, dynamic> json) => Blockhash(
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
      blockhash: json['blockhash'] as String,
    );

Map<String, dynamic> _$BlockhashToJson(Blockhash instance) => <String, dynamic>{
      'feeCalculator': instance.feeCalculator.toJson(),
      'blockhash': instance.blockhash,
    };

BlockhasValidResult _$BlockhasValidResultFromJson(Map<String, dynamic> json) =>
    BlockhasValidResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: json['value'] as bool,
    );

Map<String, dynamic> _$BlockhasValidResultToJson(
        BlockhasValidResult instance) =>
    <String, dynamic>{
      'context': instance.context.toJson(),
      'value': instance.value,
    };
