// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ParsedMessage _$$_ParsedMessageFromJson(Map<String, dynamic> json) =>
    _$_ParsedMessage(
      accountKeys: (json['accountKeys'] as List<dynamic>)
          .map((e) => AccountKey.fromJson(e as Map<String, dynamic>))
          .toList(),
      header: json['header'] == null
          ? null
          : ParsedMessageHeader.fromJson(
              json['header'] as Map<String, dynamic>),
      recentBlockhash: json['recentBlockhash'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => ParsedInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ParsedMessageToJson(_$_ParsedMessage instance) =>
    <String, dynamic>{
      'accountKeys': instance.accountKeys,
      'header': instance.header,
      'recentBlockhash': instance.recentBlockhash,
      'instructions': instance.instructions,
    };
