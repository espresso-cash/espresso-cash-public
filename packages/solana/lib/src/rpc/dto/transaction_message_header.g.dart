// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_message_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionMessageHeader _$TransactionMessageHeaderFromJson(
        Map<String, dynamic> json) =>
    TransactionMessageHeader(
      numRequiredSignatures: json['numRequiredSignatures'] as int,
      numReadonlySignedAccounts: json['numReadonlySignedAccounts'] as int,
      numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'] as int,
    );
