// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignatureStatus _$SignatureStatusFromJson(Map<String, dynamic> json) =>
    SignatureStatus(
      slot: json['slot'] as int,
      confirmations: json['confirmations'] as int?,
      err: json['err'] as Map<String, dynamic>?,
      confirmationStatus:
          _$enumDecode(_$CommitmentEnumMap, json['confirmationStatus']),
    );

Map<String, dynamic> _$SignatureStatusToJson(SignatureStatus instance) {
  final val = <String, dynamic>{
    'slot': instance.slot,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('confirmations', instance.confirmations);
  writeNotNull('err', instance.err);
  val['confirmationStatus'] = _$CommitmentEnumMap[instance.confirmationStatus];
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
