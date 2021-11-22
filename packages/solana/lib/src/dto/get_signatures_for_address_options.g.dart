// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_signatures_for_address_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSignaturesForAddressOptions _$GetSignaturesForAddressOptionsFromJson(
        Map<String, dynamic> json) =>
    GetSignaturesForAddressOptions(
      limit: json['limit'] as int?,
      before: json['before'] as String?,
      until: json['until'] as String?,
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

Map<String, dynamic> _$GetSignaturesForAddressOptionsToJson(
    GetSignaturesForAddressOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('limit', instance.limit);
  writeNotNull('before', instance.before);
  writeNotNull('until', instance.until);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
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
