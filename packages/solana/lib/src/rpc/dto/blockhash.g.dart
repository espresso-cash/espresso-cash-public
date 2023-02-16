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

BlockhasValidResult _$BlockhasValidResultFromJson(Map<String, dynamic> json) =>
    BlockhasValidResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: json['value'] as bool,
    );
