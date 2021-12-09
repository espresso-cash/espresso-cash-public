// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_spl_token_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedSplTokenTransferInstruction
    _$$ParsedSplTokenTransferInstructionFromJson(Map<String, dynamic> json) =>
        _$ParsedSplTokenTransferInstruction(
          info: SplTokenTransferInfo.fromJson(
              json['info'] as Map<String, dynamic>),
          type: json['type'] as String,
        );

Map<String, dynamic> _$$ParsedSplTokenTransferInstructionToJson(
        _$ParsedSplTokenTransferInstruction instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
    };

_$ParsedSplTokenTransferCheckedInstruction
    _$$ParsedSplTokenTransferCheckedInstructionFromJson(
            Map<String, dynamic> json) =>
        _$ParsedSplTokenTransferCheckedInstruction(
          info: SplTokenTransferCheckedInfo.fromJson(
              json['info'] as Map<String, dynamic>),
          type: json['type'] as String,
        );

Map<String, dynamic> _$$ParsedSplTokenTransferCheckedInstructionToJson(
        _$ParsedSplTokenTransferCheckedInstruction instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
    };

_$ParsedSplTokenGenericInstruction _$$ParsedSplTokenGenericInstructionFromJson(
        Map<String, dynamic> json) =>
    _$ParsedSplTokenGenericInstruction(
      info: json['info'],
      type: json['type'] as String,
    );

Map<String, dynamic> _$$ParsedSplTokenGenericInstructionToJson(
        _$ParsedSplTokenGenericInstruction instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
    };
