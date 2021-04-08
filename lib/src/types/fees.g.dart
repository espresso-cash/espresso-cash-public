// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fees _$FeesFromJson(Map<String, dynamic> json) {
  return Fees(
    blockhash: json['blockhash'] as String,
    feeCalculator: json['feeCalculator'],
    lastValidSlot: json['lastValidSlot'] as int,
  );
}
