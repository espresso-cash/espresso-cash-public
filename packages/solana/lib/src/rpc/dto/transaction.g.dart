// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedTransaction _$ParsedTransactionFromJson(Map<String, dynamic> json) =>
    ParsedTransaction(
      signatures: (json['signatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParsedTransactionToJson(ParsedTransaction instance) =>
    <String, dynamic>{
      'signatures': instance.signatures,
      'message': instance.message.toJson(),
    };
