// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirmed_signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmedSignature _$ConfirmedSignatureFromJson(Map<String, dynamic> json) =>
    ConfirmedSignature(
      signature: json['signature'] as String,
      slot: json['slot'] as int,
      err: json['err'],
      memo: json['memo'] as String?,
      blockTime: json['blockTime'] as int?,
    );

ConfirmedSignaturesResponse _$ConfirmedSignaturesResponseFromJson(
        Map<String, dynamic> json) =>
    ConfirmedSignaturesResponse(
      (json['result'] as List<dynamic>)
          .map((e) => ConfirmedSignature.fromJson(e as Map<String, dynamic>)),
    );
