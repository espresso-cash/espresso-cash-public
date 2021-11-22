// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_block_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBlockOptions _$GetBlockOptionsFromJson(Map<String, dynamic> json) =>
    GetBlockOptions(
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      transactionDetails: _$enumDecodeNullable(
          _$TransactionDetailLevelEnumMap, json['transactionDetails']),
      rewards: json['rewards'] as bool?,
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

Map<String, dynamic> _$GetBlockOptionsToJson(GetBlockOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('transactionDetails',
      _$TransactionDetailLevelEnumMap[instance.transactionDetails]);
  writeNotNull('rewards', instance.rewards);
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

const _$TransactionDetailLevelEnumMap = {
  TransactionDetailLevel.none: 'none',
  TransactionDetailLevel.full: 'full',
  TransactionDetailLevel.signatures: 'signatures',
};

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};
