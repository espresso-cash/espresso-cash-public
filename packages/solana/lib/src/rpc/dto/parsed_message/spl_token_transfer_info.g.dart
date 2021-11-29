// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spl_token_transfer_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplTokenTransferInfo _$SplTokenTransferInfoFromJson(
        Map<String, dynamic> json) =>
    SplTokenTransferInfo(
      amount: json['amount'] as String,
      authority: json['authority'] as String,
      mint: json['mint'] as String?,
      source: json['source'] as String,
      destination: json['destination'] as String,
    );

Map<String, dynamic> _$SplTokenTransferInfoToJson(
        SplTokenTransferInfo instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'authority': instance.authority,
      'mint': instance.mint,
      'source': instance.source,
      'destination': instance.destination,
    };
