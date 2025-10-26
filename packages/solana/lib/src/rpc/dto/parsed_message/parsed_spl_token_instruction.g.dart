// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_spl_token_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedSplTokenTransferInstruction _$ParsedSplTokenTransferInstructionFromJson(
  Map<String, dynamic> json,
) => ParsedSplTokenTransferInstruction(
  info: SplTokenTransferInfo.fromJson(json['info'] as Map<String, dynamic>),
  type: json['type'] as String,
);

Map<String, dynamic> _$ParsedSplTokenTransferInstructionToJson(
  ParsedSplTokenTransferInstruction instance,
) => <String, dynamic>{'info': instance.info.toJson(), 'type': instance.type};

ParsedSplTokenTransferCheckedInstruction
_$ParsedSplTokenTransferCheckedInstructionFromJson(Map<String, dynamic> json) =>
    ParsedSplTokenTransferCheckedInstruction(
      info: SplTokenTransferCheckedInfo.fromJson(
        json['info'] as Map<String, dynamic>,
      ),
      type: json['type'] as String,
    );

Map<String, dynamic> _$ParsedSplTokenTransferCheckedInstructionToJson(
  ParsedSplTokenTransferCheckedInstruction instance,
) => <String, dynamic>{'info': instance.info.toJson(), 'type': instance.type};

ParsedSplTokenGenericInstruction _$ParsedSplTokenGenericInstructionFromJson(
  Map<String, dynamic> json,
) => ParsedSplTokenGenericInstruction(
  info: json['info'],
  type: json['type'] as String,
);

Map<String, dynamic> _$ParsedSplTokenGenericInstructionToJson(
  ParsedSplTokenGenericInstruction instance,
) => <String, dynamic>{'info': instance.info, 'type': instance.type};
