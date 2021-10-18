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

_$LogsNotification _$$LogsNotificationFromJson(Map<String, dynamic> json) =>
    _$LogsNotification(
      params: NotificationParams.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => Logs.fromJson(value as Map<String, dynamic>)),
    );

Map<String, dynamic> _$$LogsNotificationToJson(_$LogsNotification instance) =>
    <String, dynamic>{
      'params': instance.params,
    };

_$ProgramNotification _$$ProgramNotificationFromJson(
        Map<String, dynamic> json) =>
    _$ProgramNotification(
      params: NotificationParams.fromJson(
          json['params'] as Map<String, dynamic>, (value) => value),
    );

Map<String, dynamic> _$$ProgramNotificationToJson(
        _$ProgramNotification instance) =>
    <String, dynamic>{
      'params': instance.params,
    };

_$SignatureNotification _$$SignatureNotificationFromJson(
        Map<String, dynamic> json) =>
    _$SignatureNotification(
      params: NotificationParams.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => OptionalError.fromJson(value as Map<String, dynamic>)),
    );

Map<String, dynamic> _$$SignatureNotificationToJson(
        _$SignatureNotification instance) =>
    <String, dynamic>{
      'params': instance.params,
    };

_$SlotNotification _$$SlotNotificationFromJson(Map<String, dynamic> json) =>
    _$SlotNotification(
      params: NotificationParams.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => Slot.fromJson(value as Map<String, dynamic>)),
    );

Map<String, dynamic> _$$SlotNotificationToJson(_$SlotNotification instance) =>
    <String, dynamic>{
      'params': instance.params,
    };
