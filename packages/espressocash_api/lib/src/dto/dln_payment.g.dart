// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dln_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentQuoteRequestDtoImpl _$$PaymentQuoteRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentQuoteRequestDtoImpl(
      amount: json['amount'] as String,
      receiverAddress: json['receiverAddress'] as String,
      receiverBlockchain: json['receiverBlockchain'] as String,
    );

Map<String, dynamic> _$$PaymentQuoteRequestDtoImplToJson(
        _$PaymentQuoteRequestDtoImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'receiverAddress': instance.receiverAddress,
      'receiverBlockchain': instance.receiverBlockchain,
    };

_$PaymentQuoteResponseDtoImpl _$$PaymentQuoteResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentQuoteResponseDtoImpl(
      inputAmount: json['inputAmount'] as String,
      receiverAmount: json['receiverAmount'] as String,
      encodedTx: json['encodedTx'] as String,
      feeInUsdc: json['feeInUsdc'] as int,
      slot: BigInt.parse(json['slot'] as String),
    );

Map<String, dynamic> _$$PaymentQuoteResponseDtoImplToJson(
        _$PaymentQuoteResponseDtoImpl instance) =>
    <String, dynamic>{
      'inputAmount': instance.inputAmount,
      'receiverAmount': instance.receiverAmount,
      'encodedTx': instance.encodedTx,
      'feeInUsdc': instance.feeInUsdc,
      'slot': instance.slot.toString(),
    };

_$OrderStatusDlnRequestDtoImpl _$$OrderStatusDlnRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderStatusDlnRequestDtoImpl(
      orderId: json['orderId'] as String,
    );

Map<String, dynamic> _$$OrderStatusDlnRequestDtoImplToJson(
        _$OrderStatusDlnRequestDtoImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
    };

_$OrderStatusDlnResponseDtoImpl _$$OrderStatusDlnResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderStatusDlnResponseDtoImpl(
      status: $enumDecode(_$DlnOrderStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$OrderStatusDlnResponseDtoImplToJson(
        _$OrderStatusDlnResponseDtoImpl instance) =>
    <String, dynamic>{
      'status': _$DlnOrderStatusEnumMap[instance.status]!,
    };

const _$DlnOrderStatusEnumMap = {
  DlnOrderStatus.none: 'None',
  DlnOrderStatus.created: 'Created',
  DlnOrderStatus.fulfilled: 'Fulfilled',
  DlnOrderStatus.sentUnlock: 'SentUnlock',
  DlnOrderStatus.orderCancelled: 'OrderCancelled',
  DlnOrderStatus.sentOrderCancel: 'SentOrderCancel',
  DlnOrderStatus.claimedUnlock: 'ClaimedUnlock',
  DlnOrderStatus.claimedOrderCancel: 'ClaimedOrderCancel',
};

_$OrderIdDlnRequestDtoImpl _$$OrderIdDlnRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderIdDlnRequestDtoImpl(
      txId: json['txId'] as String?,
    );

Map<String, dynamic> _$$OrderIdDlnRequestDtoImplToJson(
        _$OrderIdDlnRequestDtoImpl instance) =>
    <String, dynamic>{
      'txId': instance.txId,
    };

_$OrderIdDlnResponseDtoImpl _$$OrderIdDlnResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderIdDlnResponseDtoImpl(
      orderId: json['orderId'] as String,
    );

Map<String, dynamic> _$$OrderIdDlnResponseDtoImplToJson(
        _$OrderIdDlnResponseDtoImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
    };
