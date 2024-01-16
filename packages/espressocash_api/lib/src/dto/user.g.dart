// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletCountryRequestDtoImpl _$$WalletCountryRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletCountryRequestDtoImpl(
      walletAddress: json['walletAddress'] as String,
      countryCode: json['countryCode'] as String,
    );

Map<String, dynamic> _$$WalletCountryRequestDtoImplToJson(
        _$WalletCountryRequestDtoImpl instance) =>
    <String, dynamic>{
      'walletAddress': instance.walletAddress,
      'countryCode': instance.countryCode,
    };
