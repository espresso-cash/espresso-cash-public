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

Map<String, dynamic> _$FeesToJson(Fees instance) => <String, dynamic>{
      'blockhash': instance.blockhash,
      'feeCalculator': instance.feeCalculator,
      'lastValidBlockHeight': instance.lastValidBlockHeight,
    };
