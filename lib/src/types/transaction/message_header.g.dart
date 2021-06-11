// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageHeader _$MessageHeaderFromJson(Map<String, dynamic> json) {
  return MessageHeader(
    numRequiredSignatures: json['numRequiredSignatures'] as int,
    numReadonlySignedAccounts: json['numReadonlySignedAccounts'] as int,
    numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'] as int,
  );
}
