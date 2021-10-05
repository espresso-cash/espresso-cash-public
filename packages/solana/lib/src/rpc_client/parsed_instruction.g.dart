// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedInstructionSystem _$$ParsedInstructionSystemFromJson(
        Map<String, dynamic> json) =>
    _$ParsedInstructionSystem(
      programId: json['programId'] as String,
      parsed: ParsedSystemInstruction.fromJson(
          json['parsed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ParsedInstructionSystemToJson(
        _$ParsedInstructionSystem instance) =>
    <String, dynamic>{
      'programId': instance.programId,
      'parsed': instance.parsed,
    };

_$ParsedInstructionSplToken _$$ParsedInstructionSplTokenFromJson(
        Map<String, dynamic> json) =>
    _$ParsedInstructionSplToken(
      parsed: ParsedSplTokenInstruction.fromJson(
          json['parsed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ParsedInstructionSplTokenToJson(
        _$ParsedInstructionSplToken instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
    };

_$ParsedInstructionMemo _$$ParsedInstructionMemoFromJson(
        Map<String, dynamic> json) =>
    _$ParsedInstructionMemo(
      memo: json['parsed'] as String?,
    );

Map<String, dynamic> _$$ParsedInstructionMemoToJson(
        _$ParsedInstructionMemo instance) =>
    <String, dynamic>{
      'parsed': instance.memo,
    };

_$ParsedInstructionUnsupported _$$ParsedInstructionUnsupportedFromJson(
        Map<String, dynamic> json) =>
    _$ParsedInstructionUnsupported(
      program: json['program'] as String?,
    );

Map<String, dynamic> _$$ParsedInstructionUnsupportedToJson(
        _$ParsedInstructionUnsupported instance) =>
    <String, dynamic>{
      'program': instance.program,
    };
