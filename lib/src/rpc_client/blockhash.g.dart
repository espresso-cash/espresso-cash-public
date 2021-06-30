// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blockhash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blockhash _$BlockhashFromJson(Map<String, dynamic> json) {
  return Blockhash(
    feeCalculator:
        FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
    blockhash: json['blockhash'] as String,
  );
}

BlockhashResponse _$BlockhashResponseFromJson(Map<String, dynamic> json) {
  return BlockhashResponse(
    ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
        (value) => Blockhash.fromJson(value as Map<String, dynamic>)),
  );
}
