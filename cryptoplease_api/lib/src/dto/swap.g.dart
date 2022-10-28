// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SwapResponseDto _$$_SwapResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_SwapResponseDto(
      setupTransaction: json['setupTransaction'] as String?,
      swapTransaction: json['swapTransaction'] as String,
      cleanupTransaction: json['cleanupTransaction'] as String?,
    );

Map<String, dynamic> _$$_SwapResponseDtoToJson(_$_SwapResponseDto instance) =>
    <String, dynamic>{
      'setupTransaction': instance.setupTransaction,
      'swapTransaction': instance.swapTransaction,
      'cleanupTransaction': instance.cleanupTransaction,
    };
