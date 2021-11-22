// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_largest_accounts_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLargestAccountsOptions _$GetLargestAccountsOptionsFromJson(
        Map<String, dynamic> json) =>
    GetLargestAccountsOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      filter: _$enumDecodeNullable(_$CirculationStatusEnumMap, json['filter']),
    );

Map<String, dynamic> _$GetLargestAccountsOptionsToJson(
    GetLargestAccountsOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('filter', _$CirculationStatusEnumMap[instance.filter]);
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

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};

const _$CirculationStatusEnumMap = {
  CirculationStatus.circulating: 'circulating',
  CirculationStatus.nonCirculating: 'nonCirculating',
};
