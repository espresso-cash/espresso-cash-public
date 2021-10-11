// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UnsupportedNotification _$$_UnsupportedNotificationFromJson(
        Map<String, dynamic> json) =>
    _$_UnsupportedNotification();

Map<String, dynamic> _$$_UnsupportedNotificationToJson(
        _$_UnsupportedNotification instance) =>
    <String, dynamic>{};

_$AccountNotification _$$AccountNotificationFromJson(
        Map<String, dynamic> json) =>
    _$AccountNotification(
      params: NotificationParams.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => Account.fromJson(value as Map<String, dynamic>)),
    );

Map<String, dynamic> _$$AccountNotificationToJson(
        _$AccountNotification instance) =>
    <String, dynamic>{
      'params': instance.params,
    };
