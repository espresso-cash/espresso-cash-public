// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UnsupportedNotification _$UnsupportedNotificationFromJson(
  Map<String, dynamic> json,
) => _UnsupportedNotification($type: json['method'] as String?);

Map<String, dynamic> _$UnsupportedNotificationToJson(
  _UnsupportedNotification instance,
) => <String, dynamic>{'method': instance.$type};

AccountNotification _$AccountNotificationFromJson(Map<String, dynamic> json) =>
    AccountNotification(
      params: NotificationParams<Account>.fromJson(
        json['params'] as Map<String, dynamic>,
        (value) => Account.fromJson(value as Map<String, dynamic>),
      ),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$AccountNotificationToJson(
  AccountNotification instance,
) => <String, dynamic>{
  'params': instance.params.toJson((value) => value.toJson()),
  'method': instance.$type,
};

LogsNotification _$LogsNotificationFromJson(Map<String, dynamic> json) =>
    LogsNotification(
      params: NotificationParams<Logs>.fromJson(
        json['params'] as Map<String, dynamic>,
        (value) => Logs.fromJson(value as Map<String, dynamic>),
      ),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$LogsNotificationToJson(LogsNotification instance) =>
    <String, dynamic>{
      'params': instance.params.toJson((value) => value.toJson()),
      'method': instance.$type,
    };

ProgramNotification _$ProgramNotificationFromJson(Map<String, dynamic> json) =>
    ProgramNotification(
      params: NotificationParams<dynamic>.fromJson(
        json['params'] as Map<String, dynamic>,
        (value) => value,
      ),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$ProgramNotificationToJson(
  ProgramNotification instance,
) => <String, dynamic>{
  'params': instance.params.toJson((value) => value),
  'method': instance.$type,
};

SignatureNotification _$SignatureNotificationFromJson(
  Map<String, dynamic> json,
) => SignatureNotification(
  params: NotificationParams<OptionalError>.fromJson(
    json['params'] as Map<String, dynamic>,
    (value) => OptionalError.fromJson(value as Map<String, dynamic>),
  ),
  $type: json['method'] as String?,
);

Map<String, dynamic> _$SignatureNotificationToJson(
  SignatureNotification instance,
) => <String, dynamic>{
  'params': instance.params.toJson((value) => value.toJson()),
  'method': instance.$type,
};

SlotNotification _$SlotNotificationFromJson(Map<String, dynamic> json) =>
    SlotNotification(
      params: NotificationParams<Slot>.fromJson(
        json['params'] as Map<String, dynamic>,
        (value) => Slot.fromJson(value as Map<String, dynamic>),
      ),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$SlotNotificationToJson(SlotNotification instance) =>
    <String, dynamic>{
      'params': instance.params.toJson((value) => value.toJson()),
      'method': instance.$type,
    };
