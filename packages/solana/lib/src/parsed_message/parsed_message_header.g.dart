// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_message_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ParsedMessageHeader _$$_ParsedMessageHeaderFromJson(
        Map<String, dynamic> json) =>
    _$_ParsedMessageHeader(
      numRequiredSignatures: json['numRequiredSignatures'] as int,
      numReadonlySignedAccounts: json['numReadonlySignedAccounts'] as int,
      numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'] as int,
    );

Map<String, dynamic> _$$_ParsedMessageHeaderToJson(
        _$_ParsedMessageHeader instance) =>
    <String, dynamic>{
      'numRequiredSignatures': instance.numRequiredSignatures,
      'numReadonlySignedAccounts': instance.numReadonlySignedAccounts,
      'numReadonlyUnsignedAccounts': instance.numReadonlyUnsignedAccounts,
    };
