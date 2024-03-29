// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_spl_token_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedSplTokenTransferInstructionImpl
    _$$ParsedSplTokenTransferInstructionImplFromJson(
            Map<String, dynamic> json) =>
        _$ParsedSplTokenTransferInstructionImpl(
          info: SplTokenTransferInfo.fromJson(
              json['info'] as Map<String, dynamic>),
          type: json['type'] as String,
        );

Map<String, dynamic> _$$ParsedSplTokenTransferInstructionImplToJson(
        _$ParsedSplTokenTransferInstructionImpl instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'type': instance.type,
    };

_$ParsedSplTokenTransferCheckedInstructionImpl
    _$$ParsedSplTokenTransferCheckedInstructionImplFromJson(
            Map<String, dynamic> json) =>
        _$ParsedSplTokenTransferCheckedInstructionImpl(
          info: SplTokenTransferCheckedInfo.fromJson(
              json['info'] as Map<String, dynamic>),
          type: json['type'] as String,
        );

Map<String, dynamic> _$$ParsedSplTokenTransferCheckedInstructionImplToJson(
        _$ParsedSplTokenTransferCheckedInstructionImpl instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'type': instance.type,
    };

_$ParsedSplTokenGenericInstructionImpl
    _$$ParsedSplTokenGenericInstructionImplFromJson(
            Map<String, dynamic> json) =>
        _$ParsedSplTokenGenericInstructionImpl(
          info: json['info'],
          type: json['type'] as String,
        );

Map<String, dynamic> _$$ParsedSplTokenGenericInstructionImplToJson(
        _$ParsedSplTokenGenericInstructionImpl instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
    };
