// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onramp_money.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GenerateOnRampTokenResponseDto _$$_GenerateOnRampTokenResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GenerateOnRampTokenResponseDto(
      token: json['token'] as String,
      depositAddress: json['depositAddress'] as String,
    );

Map<String, dynamic> _$$_GenerateOnRampTokenResponseDtoToJson(
        _$_GenerateOnRampTokenResponseDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'depositAddress': instance.depositAddress,
    };

_$_GenerateOnRampTokenRequestDto _$$_GenerateOnRampTokenRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GenerateOnRampTokenRequestDto(
      message: json['message'] as String,
      signedMessage: json['signedMessage'] as String,
      walletAddress: json['walletAddress'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      quantity: json['quantity'] as String,
      appId: json['appId'] as String,
    );

Map<String, dynamic> _$$_GenerateOnRampTokenRequestDtoToJson(
        _$_GenerateOnRampTokenRequestDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'signedMessage': instance.signedMessage,
      'walletAddress': instance.walletAddress,
      'timestamp': instance.timestamp.toIso8601String(),
      'quantity': instance.quantity,
      'appId': instance.appId,
    };
