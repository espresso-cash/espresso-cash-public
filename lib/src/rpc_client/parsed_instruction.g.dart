// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedInstructionSystem _$_$ParsedInstructionSystemFromJson(
    Map<String, dynamic> json) {
  return _$ParsedInstructionSystem(
    programId: json['programId'] as String,
    parsed: ParsedSystemInstruction.fromJson(
        json['parsed'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$ParsedInstructionSystemToJson(
        _$ParsedInstructionSystem instance) =>
    <String, dynamic>{
      'programId': instance.programId,
      'parsed': instance.parsed,
    };

_$ParsedInstructionSplToken _$_$ParsedInstructionSplTokenFromJson(
    Map<String, dynamic> json) {
  return _$ParsedInstructionSplToken(
    parsed: ParsedSplTokenInstruction.fromJson(
        json['parsed'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$ParsedInstructionSplTokenToJson(
        _$ParsedInstructionSplToken instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
    };

_$ParsedInstructionMemo _$_$ParsedInstructionMemoFromJson(
    Map<String, dynamic> json) {
  return _$ParsedInstructionMemo(
    memo: json['parsed'] as String?,
  );
}

Map<String, dynamic> _$_$ParsedInstructionMemoToJson(
        _$ParsedInstructionMemo instance) =>
    <String, dynamic>{
      'parsed': instance.memo,
    };

_$ParsedInstructionUnsupported _$_$ParsedInstructionUnsupportedFromJson(
    Map<String, dynamic> json) {
  return _$ParsedInstructionUnsupported(
    program: json['program'] as String,
  );
}

Map<String, dynamic> _$_$ParsedInstructionUnsupportedToJson(
        _$ParsedInstructionUnsupported instance) =>
    <String, dynamic>{
      'program': instance.program,
    };
