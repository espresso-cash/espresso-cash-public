// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnsupportedNotificationImpl _$$UnsupportedNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$UnsupportedNotificationImpl(
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$UnsupportedNotificationImplToJson(
        _$UnsupportedNotificationImpl instance) =>
    <String, dynamic>{
      'method': instance.$type,
    };

_$AccountNotificationImpl _$$AccountNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$AccountNotificationImpl(
      params: NotificationParams<Account>.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => Account.fromJson(value as Map<String, dynamic>)),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$AccountNotificationImplToJson(
        _$AccountNotificationImpl instance) =>
    <String, dynamic>{
      'params': instance.params.toJson(
        (value) => value.toJson(),
      ),
      'method': instance.$type,
    };

_$LogsNotificationImpl _$$LogsNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$LogsNotificationImpl(
      params: NotificationParams<Logs>.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => Logs.fromJson(value as Map<String, dynamic>)),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$LogsNotificationImplToJson(
        _$LogsNotificationImpl instance) =>
    <String, dynamic>{
      'params': instance.params.toJson(
        (value) => value.toJson(),
      ),
      'method': instance.$type,
    };

_$ProgramNotificationImpl _$$ProgramNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$ProgramNotificationImpl(
      params: NotificationParams<dynamic>.fromJson(
          json['params'] as Map<String, dynamic>, (value) => value),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$ProgramNotificationImplToJson(
        _$ProgramNotificationImpl instance) =>
    <String, dynamic>{
      'params': instance.params.toJson(
        (value) => value,
      ),
      'method': instance.$type,
    };

_$SignatureNotificationImpl _$$SignatureNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$SignatureNotificationImpl(
      params: NotificationParams<OptionalError>.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => OptionalError.fromJson(value as Map<String, dynamic>)),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$SignatureNotificationImplToJson(
        _$SignatureNotificationImpl instance) =>
    <String, dynamic>{
      'params': instance.params.toJson(
        (value) => value.toJson(),
      ),
      'method': instance.$type,
    };

_$SlotNotificationImpl _$$SlotNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$SlotNotificationImpl(
      params: NotificationParams<Slot>.fromJson(
          json['params'] as Map<String, dynamic>,
          (value) => Slot.fromJson(value as Map<String, dynamic>)),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$SlotNotificationImplToJson(
        _$SlotNotificationImpl instance) =>
    <String, dynamic>{
      'params': instance.params.toJson(
        (value) => value.toJson(),
      ),
      'method': instance.$type,
    };
