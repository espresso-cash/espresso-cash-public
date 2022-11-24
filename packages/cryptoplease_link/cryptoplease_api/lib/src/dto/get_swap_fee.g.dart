// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_swap_fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetSwapFeeResponseDto _$$_GetSwapFeeResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GetSwapFeeResponseDto(
      feeInUsdc: json['feeInUsdc'] as int,
    );

Map<String, dynamic> _$$_GetSwapFeeResponseDtoToJson(
        _$_GetSwapFeeResponseDto instance) =>
    <String, dynamic>{
      'feeInUsdc': instance.feeInUsdc,
    };

_$_GetSwapFeeRequestDto _$$_GetSwapFeeRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GetSwapFeeRequestDto(
      route: JupiterRoute.fromJson(json['route'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GetSwapFeeRequestDtoToJson(
        _$_GetSwapFeeRequestDto instance) =>
    <String, dynamic>{
      'route': instance.route,
    };
