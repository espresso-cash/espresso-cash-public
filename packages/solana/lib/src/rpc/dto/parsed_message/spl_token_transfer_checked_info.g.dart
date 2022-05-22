// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spl_token_transfer_checked_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplTokenTransferCheckedInfo _$SplTokenTransferCheckedInfoFromJson(
        Map<String, dynamic> json) =>
    SplTokenTransferCheckedInfo(
      tokenAmount:
          TokenAmount.fromJson(json['tokenAmount'] as Map<String, dynamic>),
      source: json['source'] as String,
      destination: json['destination'] as String,
      mint: json['mint'] as String,
      multisigAuthority: json['multisigAuthority'] as String,
      signers:
          (json['signers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SplTokenTransferCheckedInfoToJson(
        SplTokenTransferCheckedInfo instance) =>
    <String, dynamic>{
      'tokenAmount': instance.tokenAmount,
      'source': instance.source,
      'destination': instance.destination,
      'mint': instance.mint,
      'multisigAuthority': instance.multisigAuthority,
      'signers': instance.signers,
    };
