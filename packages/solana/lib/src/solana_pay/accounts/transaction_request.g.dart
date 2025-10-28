// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionRequestInfo _$TransactionRequestInfoFromJson(Map<String, dynamic> json) =>
    _TransactionRequestInfo(label: json['label'] as String, icon: json['icon'] as String);

Map<String, dynamic> _$TransactionRequestInfoToJson(_TransactionRequestInfo instance) =>
    <String, dynamic>{'label': instance.label, 'icon': instance.icon};

_TransactionRequestResponse _$TransactionRequestResponseFromJson(Map<String, dynamic> json) =>
    _TransactionRequestResponse(
      transaction: json['transaction'] as String,
      message: json['message'] as String?,
      redirect: json['redirect'] as String?,
    );

Map<String, dynamic> _$TransactionRequestResponseToJson(_TransactionRequestResponse instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'message': instance.message,
      'redirect': instance.redirect,
    };
