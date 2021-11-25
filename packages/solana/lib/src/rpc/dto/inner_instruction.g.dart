// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inner_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InnerInstruction _$InnerInstructionFromJson(Map<String, dynamic> json) =>
    InnerInstruction(
      index: json['index'] as int,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
