// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scalex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScalexSignResponseDto _$$_ScalexSignResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_ScalexSignResponseDto(
      timestamp: json['timestamp'] as String,
      signature: json['signature'] as String,
    );

Map<String, dynamic> _$$_ScalexSignResponseDtoToJson(
        _$_ScalexSignResponseDto instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'signature': instance.signature,
    };

_$_ScalexSignRequestDto _$$_ScalexSignRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_ScalexSignRequestDto(
      data: json['data'] as String,
      path: json['path'] as String,
    );

Map<String, dynamic> _$$_ScalexSignRequestDtoToJson(
        _$_ScalexSignRequestDto instance) =>
    <String, dynamic>{
      'data': instance.data,
      'path': instance.path,
    };
