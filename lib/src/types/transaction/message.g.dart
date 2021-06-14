// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TxMessage _$TxMessageFromJson(Map<String, dynamic> json) {
  return TxMessage(
    header: json['header'] == null
        ? null
        : TxMessageHeader.fromJson(json['header'] as Map<String, dynamic>),
    accountKeys: (json['accountKeys'] as List<dynamic>)
        .map((e) => AccountKey.fromJson(e as Map<String, dynamic>))
        .toList(),
    recentBlockhash: json['recentBlockhash'] as String,
    instructions: (json['instructions'] as List<dynamic>)
        .map((e) => TxInstruction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
