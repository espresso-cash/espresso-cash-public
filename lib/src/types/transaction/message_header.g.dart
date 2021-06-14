// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TxMessageHeader _$TxMessageHeaderFromJson(Map<String, dynamic> json) {
  return TxMessageHeader(
    numRequiredSignatures: json['numRequiredSignatures'] as int,
    numReadonlySignedAccounts: json['numReadonlySignedAccounts'] as int,
    numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'] as int,
  );
}
