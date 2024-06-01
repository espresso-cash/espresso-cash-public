// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dln_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentQuoteRequestDtoImpl _$$PaymentQuoteRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentQuoteRequestDtoImpl(
      amount: (json['amount'] as num).toInt(),
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
      inputAmount: (json['inputAmount'] as num).toInt(),
      receiverAmount: (json['receiverAmount'] as num).toInt(),
      encodedTx: json['encodedTx'] as String,
      feeInUsdc: (json['feeInUsdc'] as num).toInt(),
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
      txId: json['txId'] as String,
    );

Map<String, dynamic> _$$OrderIdDlnRequestDtoImplToJson(
        _$OrderIdDlnRequestDtoImpl instance) =>
    <String, dynamic>{
      'txId': instance.txId,
    };

_$OrderIdDlnResponseDtoImpl _$$OrderIdDlnResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderIdDlnResponseDtoImpl(
      orderId: json['orderId'] as String?,
    );

Map<String, dynamic> _$$OrderIdDlnResponseDtoImplToJson(
        _$OrderIdDlnResponseDtoImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
    };

_$IncomingQuoteRequestDtoImpl _$$IncomingQuoteRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$IncomingQuoteRequestDtoImpl(
      amount: (json['amount'] as num).toInt(),
      senderAddress: json['senderAddress'] as String,
      senderBlockchain: json['senderBlockchain'] as String,
      receiverAddress: json['receiverAddress'] as String,
      solanaReferenceAddress: json['solanaReferenceAddress'] as String?,
    );

Map<String, dynamic> _$$IncomingQuoteRequestDtoImplToJson(
        _$IncomingQuoteRequestDtoImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'senderAddress': instance.senderAddress,
      'senderBlockchain': instance.senderBlockchain,
      'receiverAddress': instance.receiverAddress,
      'solanaReferenceAddress': instance.solanaReferenceAddress,
    };

_$IncomingQuoteResponseDtoImpl _$$IncomingQuoteResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$IncomingQuoteResponseDtoImpl(
      tx: QuoteTx.fromJson(json['tx'] as Map<String, dynamic>),
      usdcInfo:
          QuoteUsdcInfo.fromJson(json['usdcInfo'] as Map<String, dynamic>),
      inputAmount: (json['inputAmount'] as num).toInt(),
      receiverAmount: (json['receiverAmount'] as num).toInt(),
      feeInUsdc: (json['feeInUsdc'] as num).toInt(),
    );

Map<String, dynamic> _$$IncomingQuoteResponseDtoImplToJson(
        _$IncomingQuoteResponseDtoImpl instance) =>
    <String, dynamic>{
      'tx': instance.tx,
      'usdcInfo': instance.usdcInfo,
      'inputAmount': instance.inputAmount,
      'receiverAmount': instance.receiverAmount,
      'feeInUsdc': instance.feeInUsdc,
    };

_$QuoteTxImpl _$$QuoteTxImplFromJson(Map<String, dynamic> json) =>
    _$QuoteTxImpl(
      to: json['to'] as String,
      data: json['data'] as String,
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$$QuoteTxImplToJson(_$QuoteTxImpl instance) =>
    <String, dynamic>{
      'to': instance.to,
      'data': instance.data,
      'value': instance.value,
    };

_$QuoteUsdcInfoImpl _$$QuoteUsdcInfoImplFromJson(Map<String, dynamic> json) =>
    _$QuoteUsdcInfoImpl(
      usdcAddress: json['usdcAddress'] as String,
      approvalAmount: (json['approvalAmount'] as num).toInt(),
    );

Map<String, dynamic> _$$QuoteUsdcInfoImplToJson(_$QuoteUsdcInfoImpl instance) =>
    <String, dynamic>{
      'usdcAddress': instance.usdcAddress,
      'approvalAmount': instance.approvalAmount,
    };
