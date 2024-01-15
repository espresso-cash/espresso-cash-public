// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResult<T> _$NotificationResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    NotificationResult<T>(
      context:
          NotificationContext.fromJson(json['context'] as Map<String, dynamic>),
      value: fromJsonT(json['value']),
    );

Map<String, dynamic> _$NotificationResultToJson<T>(
  NotificationResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'context': instance.context.toJson(),
      'value': toJsonT(instance.value),
    };
