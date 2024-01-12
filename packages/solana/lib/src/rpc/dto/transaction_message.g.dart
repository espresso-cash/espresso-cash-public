// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionMessage _$TransactionMessageFromJson(Map<String, dynamic> json) =>
    TransactionMessage(
      accountKeys: (json['accountKeys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      header: TransactionMessageHeader.fromJson(
          json['header'] as Map<String, dynamic>),
      recentBlockhash: json['recentBlockhash'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionMessageToJson(TransactionMessage instance) =>
    <String, dynamic>{
      'accountKeys': instance.accountKeys,
      'header': instance.header.toJson(),
      'recentBlockhash': instance.recentBlockhash,
      'instructions': instance.instructions.map((e) => e.toJson()).toList(),
    };
