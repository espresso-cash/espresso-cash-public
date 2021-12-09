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
