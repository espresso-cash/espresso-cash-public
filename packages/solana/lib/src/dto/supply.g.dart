// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supply _$SupplyFromJson(Map<String, dynamic> json) => Supply(
      total: json['total'] as int,
      circulating: json['circulating'] as int,
      nonCirculating: json['nonCirculating'] as int,
      nonCirculatingAccounts: (json['nonCirculatingAccounts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SupplyToJson(Supply instance) => <String, dynamic>{
      'total': instance.total,
      'circulating': instance.circulating,
      'nonCirculating': instance.nonCirculating,
      'nonCirculatingAccounts': instance.nonCirculatingAccounts,
    };
