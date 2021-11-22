// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transaction_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTransactionOptions _$GetTransactionOptionsFromJson(
        Map<String, dynamic> json) =>
    GetTransactionOptions(
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

Map<String, dynamic> _$GetTransactionOptionsToJson(
    GetTransactionOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
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

const _$EncodingEnumMap = {
  Encoding.base64: 'base64',
  Encoding.jsonParsed: 'jsonParsed',
  Encoding.base58: 'base58',
};

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};
