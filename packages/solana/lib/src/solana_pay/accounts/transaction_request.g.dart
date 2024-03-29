// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransactionRequestInfo _$$_TransactionRequestInfoFromJson(
        Map<String, dynamic> json) =>
    _$_TransactionRequestInfo(
      label: json['label'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$$_TransactionRequestInfoToJson(
        _$_TransactionRequestInfo instance) =>
    <String, dynamic>{
      'label': instance.label,
      'icon': instance.icon,
    };

_$_TransactionRequestResponse _$$_TransactionRequestResponseFromJson(
        Map<String, dynamic> json) =>
    _$_TransactionRequestResponse(
      transaction: json['transaction'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$_TransactionRequestResponseToJson(
        _$_TransactionRequestResponse instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'message': instance.message,
    };
