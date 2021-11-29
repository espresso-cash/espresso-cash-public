// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawMessage _$RawMessageFromJson(Map<String, dynamic> json) => RawMessage(
      accountKeys: (json['accountKeys'] as List<dynamic>)
          .map((e) => AccountKey.fromJson(e))
          .toList(),
      header: json['header'] == null ? null : Header.fromJson(json['header']),
      recentBlockhash: json['recentBlockhash'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
