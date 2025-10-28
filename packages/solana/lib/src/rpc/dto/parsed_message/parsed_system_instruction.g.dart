// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_system_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedSystemTransferInstruction _$ParsedSystemTransferInstructionFromJson(
  Map<String, dynamic> json,
) => ParsedSystemTransferInstruction(
  info: ParsedSystemTransferInformation.fromJson(json['info'] as Map<String, dynamic>),
  type: json['type'] as String,
);

Map<String, dynamic> _$ParsedSystemTransferInstructionToJson(
  ParsedSystemTransferInstruction instance,
) => <String, dynamic>{'info': instance.info.toJson(), 'type': instance.type};

ParsedSystemTransferCheckedInstruction _$ParsedSystemTransferCheckedInstructionFromJson(
  Map<String, dynamic> json,
) => ParsedSystemTransferCheckedInstruction(
  info: ParsedSystemTransferInformation.fromJson(json['info'] as Map<String, dynamic>),
  type: json['type'] as String,
);

Map<String, dynamic> _$ParsedSystemTransferCheckedInstructionToJson(
  ParsedSystemTransferCheckedInstruction instance,
) => <String, dynamic>{'info': instance.info.toJson(), 'type': instance.type};

ParsedSystemUnsupportedInstruction _$ParsedSystemUnsupportedInstructionFromJson(
  Map<String, dynamic> json,
) => ParsedSystemUnsupportedInstruction(type: json['type'] as String);

Map<String, dynamic> _$ParsedSystemUnsupportedInstructionToJson(
  ParsedSystemUnsupportedInstruction instance,
) => <String, dynamic>{'type': instance.type};

_ParsedSystemTransferInformation _$ParsedSystemTransferInformationFromJson(
  Map<String, dynamic> json,
) => _ParsedSystemTransferInformation(
  lamports: (json['lamports'] as num).toInt(),
  source: json['source'] as String,
  destination: json['destination'] as String,
);

Map<String, dynamic> _$ParsedSystemTransferInformationToJson(
  _ParsedSystemTransferInformation instance,
) => <String, dynamic>{
  'lamports': instance.lamports,
  'source': instance.source,
  'destination': instance.destination,
};
