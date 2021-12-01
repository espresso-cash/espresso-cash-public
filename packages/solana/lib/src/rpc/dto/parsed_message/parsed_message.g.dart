// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedMessage _$ParsedMessageFromJson(Map<String, dynamic> json) =>
    ParsedMessage(
      accountKeys: (json['accountKeys'] as List<dynamic>)
          .map((e) => AccountKey.fromJson(e))
          .toList(),
      recentBlockhash: json['recentBlockhash'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      header: json['header'] == null ? null : Header.fromJson(json['header']),
    );
