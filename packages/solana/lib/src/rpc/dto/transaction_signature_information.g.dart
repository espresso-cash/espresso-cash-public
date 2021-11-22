// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_signature_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSignatureInformation _$TransactionSignatureInformationFromJson(
        Map<String, dynamic> json) =>
    TransactionSignatureInformation(
      signature: json['signature'] as String,
      slot: json['slot'] as int,
      err: json['err'] as Map<String, dynamic>?,
      memo: json['memo'] as String?,
      blockTime: json['blockTime'] as int?,
    );

Map<String, dynamic> _$TransactionSignatureInformationToJson(
    TransactionSignatureInformation instance) {
  final val = <String, dynamic>{
    'signature': instance.signature,
    'slot': instance.slot,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('err', instance.err);
  writeNotNull('memo', instance.memo);
  writeNotNull('blockTime', instance.blockTime);
  return val;
}
