// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Instruction _$InstructionFromJson(Map<String, dynamic> json) => Instruction(
      programIdIndex: json['programIdIndex'] as int,
      accounts:
          (json['accounts'] as List<dynamic>).map((e) => e as int).toList(),
      data: json['data'] as String,
    );

Map<String, dynamic> _$InstructionToJson(Instruction instance) =>
    <String, dynamic>{
      'programIdIndex': instance.programIdIndex,
      'accounts': instance.accounts,
      'data': instance.data,
    };
