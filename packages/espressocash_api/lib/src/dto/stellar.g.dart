// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stellar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InitiateStellarDepositRequestDtoImpl
    _$$InitiateStellarDepositRequestDtoImplFromJson(
            Map<String, dynamic> json) =>
        _$InitiateStellarDepositRequestDtoImpl(
          signedTx: json['signedTx'] as String,
        );

Map<String, dynamic> _$$InitiateStellarDepositRequestDtoImplToJson(
        _$InitiateStellarDepositRequestDtoImpl instance) =>
    <String, dynamic>{
      'signedTx': instance.signedTx,
    };

_$InitiateStellarDepositResponseDtoImpl
    _$$InitiateStellarDepositResponseDtoImplFromJson(
            Map<String, dynamic> json) =>
        _$InitiateStellarDepositResponseDtoImpl(
          url: json['url'] as String,
        );

Map<String, dynamic> _$$InitiateStellarDepositResponseDtoImplToJson(
        _$InitiateStellarDepositResponseDtoImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };
