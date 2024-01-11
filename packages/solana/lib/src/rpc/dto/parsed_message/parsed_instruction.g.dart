// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedInstructionSystemImpl _$$ParsedInstructionSystemImplFromJson(
        Map<String, dynamic> json) =>
    _$ParsedInstructionSystemImpl(
      programId: json['programId'] as String,
      parsed: ParsedSystemInstruction.fromJson(
          json['parsed'] as Map<String, dynamic>),
      $type: json['program'] as String?,
    );

Map<String, dynamic> _$$ParsedInstructionSystemImplToJson(
        _$ParsedInstructionSystemImpl instance) =>
    <String, dynamic>{
      'programId': instance.programId,
      'parsed': instance.parsed.toJson(),
      'program': instance.$type,
    };

_$ParsedInstructionSplTokenImpl _$$ParsedInstructionSplTokenImplFromJson(
        Map<String, dynamic> json) =>
    _$ParsedInstructionSplTokenImpl(
      parsed: ParsedSplTokenInstruction.fromJson(
          json['parsed'] as Map<String, dynamic>),
      $type: json['program'] as String?,
    );

Map<String, dynamic> _$$ParsedInstructionSplTokenImplToJson(
        _$ParsedInstructionSplTokenImpl instance) =>
    <String, dynamic>{
      'parsed': instance.parsed.toJson(),
      'program': instance.$type,
    };

_$ParsedInstructionMemoImpl _$$ParsedInstructionMemoImplFromJson(
        Map<String, dynamic> json) =>
    _$ParsedInstructionMemoImpl(
      memo: json['parsed'] as String?,
      $type: json['program'] as String?,
    );

Map<String, dynamic> _$$ParsedInstructionMemoImplToJson(
        _$ParsedInstructionMemoImpl instance) =>
    <String, dynamic>{
      'parsed': instance.memo,
      'program': instance.$type,
    };

_$ParsedInstructionUnsupportedImpl _$$ParsedInstructionUnsupportedImplFromJson(
        Map<String, dynamic> json) =>
    _$ParsedInstructionUnsupportedImpl(
      program: json['program'] as String?,
    );

Map<String, dynamic> _$$ParsedInstructionUnsupportedImplToJson(
        _$ParsedInstructionUnsupportedImpl instance) =>
    <String, dynamic>{
      'program': instance.program,
    };
