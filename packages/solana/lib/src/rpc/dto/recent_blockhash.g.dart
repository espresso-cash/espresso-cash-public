// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_blockhash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentBlockhash _$RecentBlockhashFromJson(Map<String, dynamic> json) =>
    RecentBlockhash(
      blockhash: json['blockhash'] as String,
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecentBlockhashToJson(RecentBlockhash instance) =>
    <String, dynamic>{
      'blockhash': instance.blockhash,
      'feeCalculator': instance.feeCalculator.toJson(),
    };

RecentBlockhashResult _$RecentBlockhashResultFromJson(
        Map<String, dynamic> json) =>
    RecentBlockhashResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: RecentBlockhash.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecentBlockhashResultToJson(
        RecentBlockhashResult instance) =>
    <String, dynamic>{
      'context': instance.context.toJson(),
      'value': instance.value.toJson(),
    };
