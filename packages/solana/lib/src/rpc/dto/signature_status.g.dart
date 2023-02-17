// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignatureStatus _$SignatureStatusFromJson(Map<String, dynamic> json) =>
    SignatureStatus(
      slot: json['slot'] as int,
      confirmationStatus:
          $enumDecode(_$CommitmentEnumMap, json['confirmationStatus']),
      confirmations: json['confirmations'] as int?,
      err: json['err'] as Map<String, dynamic>?,
    );

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};

SignatureStatusesResult _$SignatureStatusesResultFromJson(
        Map<String, dynamic> json) =>
    SignatureStatusesResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: (json['value'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : SignatureStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
