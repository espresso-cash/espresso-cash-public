// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleInstruction _$SimpleInstructionFromJson(Map<String, dynamic> json) =>
    SimpleInstruction(
      programId: json['programId'] as String,
      data: json['data'] as String,
      accounts: (json['accounts'] as List<dynamic>)
          .map((e) => AccountKey.fromJson(e))
          .toList(),
    );
