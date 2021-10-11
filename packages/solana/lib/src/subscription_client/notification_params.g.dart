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
      result: NotificationResult.fromJson(
          json['result'] as Map<String, dynamic>, (value) => fromJsonT(value)),
      subscription: json['subscription'] as int,
    );
