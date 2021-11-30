// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContextResponse<T> _$ContextResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ContextResponse<T>(
      slot: Context.fromJson(json['slot'] as Map<String, dynamic>),
      value: RpcResponse.fromJson(
          json['value'] as Map<String, dynamic>, (value) => fromJsonT(value)),
    );

Map<String, dynamic> _$ContextResponseToJson<T>(
  ContextResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'value': instance.value,
      'slot': instance.slot,
    };

Context _$ContextFromJson(Map<String, dynamic> json) => Context(
      slot: json['slot'] as int,
    );

Map<String, dynamic> _$ContextToJson(Context instance) => <String, dynamic>{
      'slot': instance.slot,
    };
