// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_supply_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSupplyOptions _$GetSupplyOptionsFromJson(Map<String, dynamic> json) =>
    GetSupplyOptions(
      commitment: _$enumDecode(_$CommitmentEnumMap, json['commitment']),
      excludeNonCirculatingAccountsList:
          json['excludeNonCirculatingAccountsList'] as bool?,
    );

Map<String, dynamic> _$GetSupplyOptionsToJson(GetSupplyOptions instance) {
  final val = <String, dynamic>{
    'commitment': _$CommitmentEnumMap[instance.commitment],
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('excludeNonCirculatingAccountsList',
      instance.excludeNonCirculatingAccountsList);
  return val;
}

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

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};
