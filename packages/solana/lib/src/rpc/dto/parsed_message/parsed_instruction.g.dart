// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedInstructionSystem _$ParsedInstructionSystemFromJson(Map<String, dynamic> json) =>
    ParsedInstructionSystem(
      programId: json['programId'] as String,
      parsed: ParsedSystemInstruction.fromJson(json['parsed'] as Map<String, dynamic>),
      $type: json['program'] as String?,
    );

Map<String, dynamic> _$ParsedInstructionSystemToJson(ParsedInstructionSystem instance) =>
    <String, dynamic>{
      'programId': instance.programId,
      'parsed': instance.parsed.toJson(),
      'program': instance.$type,
    };

ParsedInstructionSplToken _$ParsedInstructionSplTokenFromJson(Map<String, dynamic> json) =>
    ParsedInstructionSplToken(
      parsed: ParsedSplTokenInstruction.fromJson(json['parsed'] as Map<String, dynamic>),
      $type: json['program'] as String?,
    );

Map<String, dynamic> _$ParsedInstructionSplTokenToJson(ParsedInstructionSplToken instance) =>
    <String, dynamic>{'parsed': instance.parsed.toJson(), 'program': instance.$type};

ParsedInstructionMemo _$ParsedInstructionMemoFromJson(Map<String, dynamic> json) =>
    ParsedInstructionMemo(memo: json['parsed'] as String?, $type: json['program'] as String?);

Map<String, dynamic> _$ParsedInstructionMemoToJson(ParsedInstructionMemo instance) =>
    <String, dynamic>{'parsed': instance.memo, 'program': instance.$type};

ParsedInstructionUnsupported _$ParsedInstructionUnsupportedFromJson(Map<String, dynamic> json) =>
    ParsedInstructionUnsupported(program: json['program'] as String?);

Map<String, dynamic> _$ParsedInstructionUnsupportedToJson(ParsedInstructionUnsupported instance) =>
    <String, dynamic>{'program': instance.program};
