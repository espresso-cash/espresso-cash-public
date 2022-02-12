// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UnsupportedNotification _$$_UnsupportedNotificationFromJson(
        Map<String, dynamic> json) =>
    _$_UnsupportedNotification(
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$_UnsupportedNotificationToJson(
        _$_UnsupportedNotification instance) =>
    <String, dynamic>{
      'method': instance.$type,
    };

_$AccountNotification _$$AccountNotificationFromJson(
        Map<String, dynamic> json) =>
    _$AccountNotification(
      params: NotificationParams<Account>.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => Account.fromJson(value as Map<String, dynamic>)),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$AccountNotificationToJson(
        _$AccountNotification instance) =>
    <String, dynamic>{
      'params': instance.params,
      'method': instance.$type,
    };

_$LogsNotification _$$LogsNotificationFromJson(Map<String, dynamic> json) =>
    _$LogsNotification(
      params: NotificationParams<Logs>.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => Logs.fromJson(value as Map<String, dynamic>)),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$LogsNotificationToJson(_$LogsNotification instance) =>
    <String, dynamic>{
      'params': instance.params,
      'method': instance.$type,
    };

_$ProgramNotification _$$ProgramNotificationFromJson(
        Map<String, dynamic> json) =>
    _$ProgramNotification(
      params: NotificationParams<dynamic>.fromJson(
          json['params'] as Map<String, dynamic>, (value) => value),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$ProgramNotificationToJson(
        _$ProgramNotification instance) =>
    <String, dynamic>{
      'params': instance.params,
      'method': instance.$type,
    };

_$SignatureNotification _$$SignatureNotificationFromJson(
        Map<String, dynamic> json) =>
    _$SignatureNotification(
      params: NotificationParams<OptionalError>.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => OptionalError.fromJson(value as Map<String, dynamic>)),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$SignatureNotificationToJson(
        _$SignatureNotification instance) =>
    <String, dynamic>{
      'params': instance.params,
      'method': instance.$type,
    };

_$SlotNotification _$$SlotNotificationFromJson(Map<String, dynamic> json) =>
    _$SlotNotification(
      params: NotificationParams<Slot>.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => Slot.fromJson(value as Map<String, dynamic>)),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$SlotNotificationToJson(_$SlotNotification instance) =>
    <String, dynamic>{
      'params': instance.params,
      'method': instance.$type,
    };
