// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stake_activation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StakeActivation _$StakeActivationFromJson(Map<String, dynamic> json) =>
    StakeActivation(
      state: _$enumDecode(_$StakeActivationStateEnumMap, json['state']),
      active: json['active'] as int,
      inactive: json['inactive'] as int,
    );

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$StakeActivationStateEnumMap = {
  StakeActivationState.activating: 'activating',
  StakeActivationState.active: 'active',
  StakeActivationState.deactivating: 'deactivating',
  StakeActivationState.inactive: 'inactive',
};
