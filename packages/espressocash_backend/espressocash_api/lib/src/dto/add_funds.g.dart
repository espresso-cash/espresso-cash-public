// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_funds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddFundsResponseDto _$$_AddFundsResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_AddFundsResponseDto(
      signedUrl: json['signedUrl'] as String,
    );

Map<String, dynamic> _$$_AddFundsResponseDtoToJson(
        _$_AddFundsResponseDto instance) =>
    <String, dynamic>{
      'signedUrl': instance.signedUrl,
    };

_$_AddFundsRequestDto _$$_AddFundsRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_AddFundsRequestDto(
      receiverAddress: json['receiverAddress'] as String,
      tokenSymbol: json['tokenSymbol'] as String,
    );

Map<String, dynamic> _$$_AddFundsRequestDtoToJson(
        _$_AddFundsRequestDto instance) =>
    <String, dynamic>{
      'receiverAddress': instance.receiverAddress,
      'tokenSymbol': instance.tokenSymbol,
    };
