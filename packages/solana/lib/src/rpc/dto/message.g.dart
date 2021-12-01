// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      accountKeys: (json['accountKeys'] as List<dynamic>)
          .map((e) => AccountKey.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentBlockhash: json['recentBlockhash'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      header: (json['header'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );
