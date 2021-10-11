// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedMessage _$ParsedMessageFromJson(Map<String, dynamic> json) =>
    ParsedMessage(
      header: json['header'] == null
          ? null
          : ParsedMessageHeader.fromJson(
              json['header'] as Map<String, dynamic>),
      accountKeys: (json['accountKeys'] as List<dynamic>)
          .map((e) => AccountKey.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentBlockhash: json['recentBlockhash'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => ParsedInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
