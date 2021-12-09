// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_signature_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSignatureInformation _$TransactionSignatureInformationFromJson(
        Map<String, dynamic> json) =>
    TransactionSignatureInformation(
      signature: json['signature'] as String,
      slot: json['slot'] as int,
      err: json['err'] as Map<String, dynamic>?,
      memo: json['memo'] as String?,
      blockTime: json['blockTime'] as int?,
    );
