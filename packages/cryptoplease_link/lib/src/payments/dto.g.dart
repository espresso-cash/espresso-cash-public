// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreatePaymentRequestDto _$$_CreatePaymentRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CreatePaymentRequestDto(
      senderAccount: json['senderAccount'] as String,
      escrowAccount: json['escrowAccount'] as String,
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$$_CreatePaymentRequestDtoToJson(
        _$_CreatePaymentRequestDto instance) =>
    <String, dynamic>{
      'senderAccount': instance.senderAccount,
      'escrowAccount': instance.escrowAccount,
      'amount': instance.amount,
    };

_$_CreatePaymentResponseDto _$$_CreatePaymentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CreatePaymentResponseDto(
      transaction: json['transaction'] as String,
    );

Map<String, dynamic> _$$_CreatePaymentResponseDtoToJson(
        _$_CreatePaymentResponseDto instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
    };

_$_ReceivePaymentRequestDto _$$_ReceivePaymentRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_ReceivePaymentRequestDto(
      receiverAccount: json['receiverAccount'] as String,
      escrowAccount: json['escrowAccount'] as String,
    );

Map<String, dynamic> _$$_ReceivePaymentRequestDtoToJson(
        _$_ReceivePaymentRequestDto instance) =>
    <String, dynamic>{
      'receiverAccount': instance.receiverAccount,
      'escrowAccount': instance.escrowAccount,
    };

_$_ReceivePaymentResponseDto _$$_ReceivePaymentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_ReceivePaymentResponseDto(
      transaction: json['transaction'] as String,
    );

Map<String, dynamic> _$$_ReceivePaymentResponseDtoToJson(
        _$_ReceivePaymentResponseDto instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
    };
