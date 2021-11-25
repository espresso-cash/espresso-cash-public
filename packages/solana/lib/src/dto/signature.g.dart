// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSignatureItem _$GetSignatureItemFromJson(Map<String, dynamic> json) => Signature(
  signature: json['signature'] as String,
  slot: json['slot'] as int,
  blockTime: json['blockTime'] as int?,
);

GetSignatureResponse _$GetSignatureResponseFromJson(Map<String, dynamic> json) =>
    SignatureResponse(
      jsonrpc: json['jsonrpc'] as String,
      result: (json['result'] as List<dynamic>)
          .map((e) => GetSignatureItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String,
    );
