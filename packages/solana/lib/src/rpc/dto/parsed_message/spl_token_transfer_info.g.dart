// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spl_token_transfer_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplTokenTransferInfo _$SplTokenTransferInfoFromJson(
        Map<String, dynamic> json) =>
    SplTokenTransferInfo(
      amount: json['amount'] as String,
      source: json['source'] as String,
      destination: json['destination'] as String,
      authority: json['authority'] as String?,
      multisigAuthority: json['multisigAuthority'] as String?,
      signers:
          (json['signers'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SplTokenTransferInfoToJson(
        SplTokenTransferInfo instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'source': instance.source,
      'destination': instance.destination,
      'authority': instance.authority,
      'multisigAuthority': instance.multisigAuthority,
      'signers': instance.signers,
    };
