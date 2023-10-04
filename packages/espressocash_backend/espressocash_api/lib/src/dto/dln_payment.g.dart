// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dln_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentQuoteRequestDto _$$_PaymentQuoteRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_PaymentQuoteRequestDto(
      amount: json['amount'] as String,
      senderAddress: json['senderAddress'] as String,
      receiverAddress: json['receiverAddress'] as String,
      receiverBlockchain: json['receiverBlockchain'] as String,
    );

Map<String, dynamic> _$$_PaymentQuoteRequestDtoToJson(
        _$_PaymentQuoteRequestDto instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'senderAddress': instance.senderAddress,
      'receiverAddress': instance.receiverAddress,
      'receiverBlockchain': instance.receiverBlockchain,
    };

_$_PaymentQuoteResponseDto _$$_PaymentQuoteResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_PaymentQuoteResponseDto(
      senderDeductAmount: json['senderDeductAmount'] as String,
      receiverAmount: json['receiverAmount'] as String,
      encodedTx: json['encodedTx'] as String,
      feeInUsdc: json['feeInUsdc'] as int,
      slot: BigInt.parse(json['slot'] as String),
    );

Map<String, dynamic> _$$_PaymentQuoteResponseDtoToJson(
        _$_PaymentQuoteResponseDto instance) =>
    <String, dynamic>{
      'senderDeductAmount': instance.senderDeductAmount,
      'receiverAmount': instance.receiverAmount,
      'encodedTx': instance.encodedTx,
      'feeInUsdc': instance.feeInUsdc,
      'slot': instance.slot.toString(),
    };
