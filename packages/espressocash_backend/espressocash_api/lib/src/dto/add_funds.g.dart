// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_funds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddFundsResponseDtoImpl _$$AddFundsResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$AddFundsResponseDtoImpl(
      signedUrl: json['signedUrl'] as String,
    );

Map<String, dynamic> _$$AddFundsResponseDtoImplToJson(
        _$AddFundsResponseDtoImpl instance) =>
    <String, dynamic>{
      'signedUrl': instance.signedUrl,
    };

_$AddFundsRequestDtoImpl _$$AddFundsRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$AddFundsRequestDtoImpl(
      receiverAddress: json['receiverAddress'] as String,
      tokenSymbol: json['tokenSymbol'] as String,
    );

Map<String, dynamic> _$$AddFundsRequestDtoImplToJson(
        _$AddFundsRequestDtoImpl instance) =>
    <String, dynamic>{
      'receiverAddress': instance.receiverAddress,
      'tokenSymbol': instance.tokenSymbol,
    };
