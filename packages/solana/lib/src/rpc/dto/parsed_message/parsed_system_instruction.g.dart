// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_system_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedSystemTransferInstruction _$$ParsedSystemTransferInstructionFromJson(
        Map<String, dynamic> json) =>
    _$ParsedSystemTransferInstruction(
      info: ParsedSystemTransferInformation.fromJson(
          json['info'] as Map<String, dynamic>),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$ParsedSystemTransferInstructionToJson(
        _$ParsedSystemTransferInstruction instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
    };

_$ParsedSystemTransferCheckedInstruction
    _$$ParsedSystemTransferCheckedInstructionFromJson(
            Map<String, dynamic> json) =>
        _$ParsedSystemTransferCheckedInstruction(
          info: ParsedSystemTransferInformation.fromJson(
              json['info'] as Map<String, dynamic>),
          type: json['type'] as String,
        );

Map<String, dynamic> _$$ParsedSystemTransferCheckedInstructionToJson(
        _$ParsedSystemTransferCheckedInstruction instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
    };

_$ParsedSystemUnsupportedInstruction
    _$$ParsedSystemUnsupportedInstructionFromJson(Map<String, dynamic> json) =>
        _$ParsedSystemUnsupportedInstruction(
          type: json['type'] as String,
        );

Map<String, dynamic> _$$ParsedSystemUnsupportedInstructionToJson(
        _$ParsedSystemUnsupportedInstruction instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

_$_ParsedSystemTransferInformation _$$_ParsedSystemTransferInformationFromJson(
        Map<String, dynamic> json) =>
    _$_ParsedSystemTransferInformation(
      lamports: json['lamports'] as int,
      source: json['source'] as String,
      destination: json['destination'] as String,
    );

Map<String, dynamic> _$$_ParsedSystemTransferInformationToJson(
        _$_ParsedSystemTransferInformation instance) =>
    <String, dynamic>{
      'lamports': instance.lamports,
      'source': instance.source,
      'destination': instance.destination,
    };
