// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_rate_governor_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeeRateGovernorValue _$FeeRateGovernorValueFromJson(
        Map<String, dynamic> json) =>
    FeeRateGovernorValue(
      burnPercent: json['burnPercent'] as int,
      maxLamportsPerSignature: json['maxLamportsPerSignature'] as int,
      minLamportsPerSignature: json['minLamportsPerSignature'] as int,
      targetLamportsPerSignature: json['targetLamportsPerSignature'] as int,
      targetSignaturesPerSlot: json['targetSignaturesPerSlot'] as int,
    );
