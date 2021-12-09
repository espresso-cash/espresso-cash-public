// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delegation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Delegation _$DelegationFromJson(Map<String, dynamic> json) => Delegation(
      activationEpoch: json['activationEpoch'] as String,
      deactivationEpoch: json['deactivationEpoch'] as String,
      stake: json['stake'] as String,
      voter: json['voter'] as String,
      warmupCooldownRate: (json['warmupCooldownRate'] as num).toDouble(),
    );

Map<String, dynamic> _$DelegationToJson(Delegation instance) =>
    <String, dynamic>{
      'activationEpoch': instance.activationEpoch,
      'deactivationEpoch': instance.deactivationEpoch,
      'stake': instance.stake,
      'voter': instance.voter,
      'warmupCooldownRate': instance.warmupCooldownRate,
    };
