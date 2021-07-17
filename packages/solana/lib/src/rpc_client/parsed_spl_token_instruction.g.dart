// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_spl_token_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedSplTokenTransferInstruction
    _$_$ParsedSplTokenTransferInstructionFromJson(Map<String, dynamic> json) {
  return _$ParsedSplTokenTransferInstruction(
    info: ParsedSplTokenTransferInformation.fromJson(
        json['info'] as Map<String, dynamic>),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$_$ParsedSplTokenTransferInstructionToJson(
        _$ParsedSplTokenTransferInstruction instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
    };

_$ParsedSplTokenUnsupportedInstruction
    _$_$ParsedSplTokenUnsupportedInstructionFromJson(
        Map<String, dynamic> json) {
  return _$ParsedSplTokenUnsupportedInstruction(
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$_$ParsedSplTokenUnsupportedInstructionToJson(
        _$ParsedSplTokenUnsupportedInstruction instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

_$_ParsedSplTokenTransferInformation
    _$_$_ParsedSplTokenTransferInformationFromJson(Map<String, dynamic> json) {
  return _$_ParsedSplTokenTransferInformation(
    amount: json['amount'] as String,
    authority: json['authority'] as String,
    source: json['source'] as String,
    destination: json['destination'] as String,
  );
}

Map<String, dynamic> _$_$_ParsedSplTokenTransferInformationToJson(
        _$_ParsedSplTokenTransferInformation instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'authority': instance.authority,
      'source': instance.source,
      'destination': instance.destination,
    };
