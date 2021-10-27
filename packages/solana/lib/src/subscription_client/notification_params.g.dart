// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationParamsSignature _$$_NotificationParamsSignatureFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationParamsSignature(
      result: NotificationResult<OptionalError>.fromJson(
          json['result'] as Map<String, dynamic>,
          (value) => OptionalError.fromJson(value as Map<String, dynamic>)),
      subscription: json['subscription'] as int,
    );

Map<String, dynamic> _$$_NotificationParamsSignatureToJson(
        _$_NotificationParamsSignature instance) =>
    <String, dynamic>{
      'result': instance.result,
      'subscription': instance.subscription,
    };

_$_NotificationParamsLogs _$$_NotificationParamsLogsFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationParamsLogs(
      result: NotificationResult<Logs>.fromJson(
          json['result'] as Map<String, dynamic>,
          (value) => Logs.fromJson(value as Map<String, dynamic>)),
      subscription: json['subscription'] as int,
    );

Map<String, dynamic> _$$_NotificationParamsLogsToJson(
        _$_NotificationParamsLogs instance) =>
    <String, dynamic>{
      'result': instance.result,
      'subscription': instance.subscription,
    };

_$_NotificationParamsSlot _$$_NotificationParamsSlotFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationParamsSlot(
      result: NotificationResult<Slot>.fromJson(
          json['result'] as Map<String, dynamic>,
          (value) => Slot.fromJson(value as Map<String, dynamic>)),
      subscription: json['subscription'] as int,
    );

Map<String, dynamic> _$$_NotificationParamsSlotToJson(
        _$_NotificationParamsSlot instance) =>
    <String, dynamic>{
      'result': instance.result,
      'subscription': instance.subscription,
    };

_$_NotificationParamsAccount _$$_NotificationParamsAccountFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationParamsAccount(
      result: NotificationResult<Account>.fromJson(
          json['result'] as Map<String, dynamic>,
          (value) => Account.fromJson(value as Map<String, dynamic>)),
      subscription: json['subscription'] as int,
    );

Map<String, dynamic> _$$_NotificationParamsAccountToJson(
        _$_NotificationParamsAccount instance) =>
    <String, dynamic>{
      'result': instance.result,
      'subscription': instance.subscription,
    };

_$_NotificationParamsGeneric _$$_NotificationParamsGenericFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationParamsGeneric(
      result: NotificationResult<Map<String, dynamic>>.fromJson(
          json['result'] as Map<String, dynamic>,
          (value) => value as Map<String, dynamic>),
      subscription: json['subscription'] as int,
    );

Map<String, dynamic> _$$_NotificationParamsGenericToJson(
        _$_NotificationParamsGeneric instance) =>
    <String, dynamic>{
      'result': instance.result,
      'subscription': instance.subscription,
    };
