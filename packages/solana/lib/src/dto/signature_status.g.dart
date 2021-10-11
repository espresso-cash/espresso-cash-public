// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignatureStatus _$SignatureStatusFromJson(Map<String, dynamic> json) =>
    SignatureStatus(
      slot: json['slot'] as int,
      confirmations: json['confirmations'] as int?,
      err: json['err'],
      confirmationStatus:
          _$enumDecodeNullable(_$CommitmentEnumMap, json['confirmationStatus']),
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

SignatureStatusesResponse _$SignatureStatusesResponseFromJson(
        Map<String, dynamic> json) =>
    SignatureStatusesResponse(
      result: _SignatureStatusesResult.fromJson(
          json['result'] as Map<String, dynamic>),
    );

_SignatureStatusesResult _$SignatureStatusesResultFromJson(
        Map<String, dynamic> json) =>
    _SignatureStatusesResult(
      value: const _NullableListConverter().fromJson(json['value'] as List),
    );
