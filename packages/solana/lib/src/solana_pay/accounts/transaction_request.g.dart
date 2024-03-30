// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionRequestInfoImpl _$$TransactionRequestInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionRequestInfoImpl(
      label: json['label'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$$TransactionRequestInfoImplToJson(
        _$TransactionRequestInfoImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'icon': instance.icon,
    };

_$TransactionRequestResponseImpl _$$TransactionRequestResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionRequestResponseImpl(
      transaction: json['transaction'] as String,
      message: json['message'] as String?,
      redirect: json['redirect'] as String?,
    );

Map<String, dynamic> _$$TransactionRequestResponseImplToJson(
        _$TransactionRequestResponseImpl instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'message': instance.message,
      'redirect': instance.redirect,
    };
