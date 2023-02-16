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

SupplyResult _$SupplyResultFromJson(Map<String, dynamic> json) => SupplyResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: Supply.fromJson(json['value'] as Map<String, dynamic>),
    );
