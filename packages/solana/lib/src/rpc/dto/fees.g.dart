// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fees _$FeesFromJson(Map<String, dynamic> json) => Fees(
      blockhash: json['blockhash'] as String,
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
      lastValidBlockHeight: json['lastValidBlockHeight'] as int,
    );

FeesResult _$FeesResultFromJson(Map<String, dynamic> json) => FeesResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: Fees.fromJson(json['value'] as Map<String, dynamic>),
    );
