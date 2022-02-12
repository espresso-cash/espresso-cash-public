// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stake_activation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StakeActivation _$StakeActivationFromJson(Map<String, dynamic> json) =>
    StakeActivation(
      state: $enumDecode(_$StakeActivationStateEnumMap, json['state']),
      active: json['active'] as int,
      inactive: json['inactive'] as int,
    );

const _$StakeActivationStateEnumMap = {
  StakeActivationState.activating: 'activating',
  StakeActivationState.active: 'active',
  StakeActivationState.deactivating: 'deactivating',
  StakeActivationState.inactive: 'inactive',
};
