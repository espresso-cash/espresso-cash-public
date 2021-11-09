// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationParams<T> _$NotificationParamsFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    NotificationParams<T>(
      result: fromJsonT(json['result']),
      subscription: json['subscription'] as int,
    );

Map<String, dynamic> _$NotificationParamsToJson<T>(
  NotificationParams<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'result': toJsonT(instance.result),
      'subscription': instance.subscription,
    };
