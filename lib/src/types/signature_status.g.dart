// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignatureStatus _$SignatureStatusFromJson(Map<String, dynamic> json) {
  return SignatureStatus(
    slot: json['slot'] as int,
    confirmations: json['confirmations'] as int,
    err: json['err'],
    confirmationStatus:
        _$enumDecodeNullable(_$TxStatusEnumMap, json['confirmationStatus']),
  );
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TxStatusEnumMap = {
  TxStatus.processed: 'processed',
  TxStatus.confirmed: 'confirmed',
  TxStatus.finalized: 'finalized',
};

SignatureStatusesResponse _$SignatureStatusesResponseFromJson(
    Map<String, dynamic> json) {
  return SignatureStatusesResponse(
    json['result'] == null
        ? null
        : ValueResponse.fromJson(
            json['result'] as Map<String, dynamic>,
            (value) => (value as List)?.map((e) => e == null
                ? null
                : SignatureStatus.fromJson(e as Map<String, dynamic>))),
  );
}
