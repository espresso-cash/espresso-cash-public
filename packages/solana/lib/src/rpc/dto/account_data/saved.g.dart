// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenAccount _$TokenAccountFromJson(Map<String, dynamic> json) => TokenAccount(
      decimals: json['decimals'] as int,
      freezeAuthority: json['freezeAuthority'] as String?,
      isInitialized: json['isInitialized'] as bool,
      mintAuthority: json['mintAuthority'] as String,
      supply: json['supply'] as String,
    );

Map<String, dynamic> _$TokenAccountToJson(TokenAccount instance) =>
    <String, dynamic>{
      'decimals': instance.decimals,
      'freezeAuthority': instance.freezeAuthority,
      'isInitialized': instance.isInitialized,
      'mintAuthority': instance.mintAuthority,
      'supply': instance.supply,
    };
