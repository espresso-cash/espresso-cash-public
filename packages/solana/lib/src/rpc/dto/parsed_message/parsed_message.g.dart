// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedMessage _$ParsedMessageFromJson(Map<String, dynamic> json) =>
    ParsedMessage(
      accountKeys: (json['accountKeys'] as List<dynamic>)
          .map(AccountKey.fromJson)
          .toList(),
      recentBlockhash: json['recentBlockhash'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      header: json['header'] == null ? null : Header.fromJson(json['header']),
      addressTableLookups: (json['addressTableLookups'] as List<dynamic>?)
          ?.map((e) => AddressTableLookups.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParsedMessageToJson(ParsedMessage instance) =>
    <String, dynamic>{
      'accountKeys': instance.accountKeys.map((e) => e.toJson()).toList(),
      'header': instance.header?.toJson(),
      'recentBlockhash': instance.recentBlockhash,
      'instructions': instance.instructions.map((e) => e.toJson()).toList(),
      'addressTableLookups':
          instance.addressTableLookups?.map((e) => e.toJson()).toList(),
    };
