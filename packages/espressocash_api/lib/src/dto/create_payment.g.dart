// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreatePaymentRequestDtoImpl _$$CreatePaymentRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePaymentRequestDtoImpl(
      senderAccount: json['senderAccount'] as String,
      escrowAccount: json['escrowAccount'] as String,
      amount: (json['amount'] as num).toInt(),
      cluster: $enumDecode(_$ClusterEnumMap, json['cluster']),
      durable: json['durable'] as bool? ?? false,
    );

Map<String, dynamic> _$$CreatePaymentRequestDtoImplToJson(
        _$CreatePaymentRequestDtoImpl instance) =>
    <String, dynamic>{
      'senderAccount': instance.senderAccount,
      'escrowAccount': instance.escrowAccount,
      'amount': instance.amount,
      'cluster': _$ClusterEnumMap[instance.cluster]!,
      'durable': instance.durable,
    };

const _$ClusterEnumMap = {
  Cluster.mainnet: 'mainnet',
  Cluster.devnet: 'devnet',
};

_$CreatePaymentResponseDtoImpl _$$CreatePaymentResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePaymentResponseDtoImpl(
      transaction: json['transaction'] as String,
      slot: BigInt.parse(json['slot'] as String),
    );

Map<String, dynamic> _$$CreatePaymentResponseDtoImplToJson(
        _$CreatePaymentResponseDtoImpl instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'slot': instance.slot.toString(),
    };

_$ReceivePaymentRequestDtoImpl _$$ReceivePaymentRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ReceivePaymentRequestDtoImpl(
      receiverAccount: json['receiverAccount'] as String,
      escrowAccount: json['escrowAccount'] as String,
      cluster: $enumDecode(_$ClusterEnumMap, json['cluster']),
      durable: json['durable'] as bool? ?? false,
    );

Map<String, dynamic> _$$ReceivePaymentRequestDtoImplToJson(
        _$ReceivePaymentRequestDtoImpl instance) =>
    <String, dynamic>{
      'receiverAccount': instance.receiverAccount,
      'escrowAccount': instance.escrowAccount,
      'cluster': _$ClusterEnumMap[instance.cluster]!,
      'durable': instance.durable,
    };

_$ReceivePaymentResponseDtoImpl _$$ReceivePaymentResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ReceivePaymentResponseDtoImpl(
      transaction: json['transaction'] as String,
      slot: BigInt.parse(json['slot'] as String),
    );

Map<String, dynamic> _$$ReceivePaymentResponseDtoImplToJson(
        _$ReceivePaymentResponseDtoImpl instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'slot': instance.slot.toString(),
    };

_$CreateDirectPaymentRequestDtoImpl
    _$$CreateDirectPaymentRequestDtoImplFromJson(Map<String, dynamic> json) =>
        _$CreateDirectPaymentRequestDtoImpl(
          senderAccount: json['senderAccount'] as String,
          receiverAccount: json['receiverAccount'] as String,
          referenceAccount: json['referenceAccount'] as String?,
          amount: (json['amount'] as num).toInt(),
          cluster: $enumDecode(_$ClusterEnumMap, json['cluster']),
          durable: json['durable'] as bool? ?? false,
        );

Map<String, dynamic> _$$CreateDirectPaymentRequestDtoImplToJson(
        _$CreateDirectPaymentRequestDtoImpl instance) =>
    <String, dynamic>{
      'senderAccount': instance.senderAccount,
      'receiverAccount': instance.receiverAccount,
      'referenceAccount': instance.referenceAccount,
      'amount': instance.amount,
      'cluster': _$ClusterEnumMap[instance.cluster]!,
      'durable': instance.durable,
    };

_$CreateDirectPaymentResponseDtoImpl
    _$$CreateDirectPaymentResponseDtoImplFromJson(Map<String, dynamic> json) =>
        _$CreateDirectPaymentResponseDtoImpl(
          fee: (json['fee'] as num).toInt(),
          transaction: json['transaction'] as String,
          slot: BigInt.parse(json['slot'] as String),
        );

Map<String, dynamic> _$$CreateDirectPaymentResponseDtoImplToJson(
        _$CreateDirectPaymentResponseDtoImpl instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'transaction': instance.transaction,
      'slot': instance.slot.toString(),
    };

_$CancelPaymentRequestDtoImpl _$$CancelPaymentRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CancelPaymentRequestDtoImpl(
      senderAccount: json['senderAccount'] as String,
      escrowAccount: json['escrowAccount'] as String,
      cluster: $enumDecode(_$ClusterEnumMap, json['cluster']),
      durable: json['durable'] as bool? ?? false,
    );

Map<String, dynamic> _$$CancelPaymentRequestDtoImplToJson(
        _$CancelPaymentRequestDtoImpl instance) =>
    <String, dynamic>{
      'senderAccount': instance.senderAccount,
      'escrowAccount': instance.escrowAccount,
      'cluster': _$ClusterEnumMap[instance.cluster]!,
      'durable': instance.durable,
    };

_$CancelPaymentResponseDtoImpl _$$CancelPaymentResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CancelPaymentResponseDtoImpl(
      transaction: json['transaction'] as String,
      slot: BigInt.parse(json['slot'] as String),
    );

Map<String, dynamic> _$$CancelPaymentResponseDtoImplToJson(
        _$CancelPaymentResponseDtoImpl instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'slot': instance.slot.toString(),
    };
