// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_system_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedSystemTransferInstruction _$_$ParsedSystemTransferInstructionFromJson(
    Map<String, dynamic> json) {
  return _$ParsedSystemTransferInstruction(
    info: ParsedSystemTransferInformation.fromJson(
        json['info'] as Map<String, dynamic>),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$_$ParsedSystemTransferInstructionToJson(
        _$ParsedSystemTransferInstruction instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
    };

_$ParsedSystemUnsupportedInstruction
    _$_$ParsedSystemUnsupportedInstructionFromJson(Map<String, dynamic> json) {
  return _$ParsedSystemUnsupportedInstruction(
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$_$ParsedSystemUnsupportedInstructionToJson(
        _$ParsedSystemUnsupportedInstruction instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

_$_ParsedSystemTransferInformation _$_$_ParsedSystemTransferInformationFromJson(
    Map<String, dynamic> json) {
  return _$_ParsedSystemTransferInformation(
    lamports: json['lamports'] as int,
    source: json['source'] as String,
    destination: json['destination'] as String,
  );
}

Map<String, dynamic> _$_$_ParsedSystemTransferInformationToJson(
        _$_ParsedSystemTransferInformation instance) =>
    <String, dynamic>{
      'lamports': instance.lamports,
      'source': instance.source,
      'destination': instance.destination,
    };
