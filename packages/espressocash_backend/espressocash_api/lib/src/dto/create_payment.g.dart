// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreatePaymentRequestDto _$$_CreatePaymentRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CreatePaymentRequestDto(
      senderAccount: json['senderAccount'] as String,
      escrowAccount: json['escrowAccount'] as String,
      amount: json['amount'] as int,
      cluster: $enumDecode(_$ClusterEnumMap, json['cluster']),
    );

Map<String, dynamic> _$$_CreatePaymentRequestDtoToJson(
        _$_CreatePaymentRequestDto instance) =>
    <String, dynamic>{
      'senderAccount': instance.senderAccount,
      'escrowAccount': instance.escrowAccount,
      'amount': instance.amount,
      'cluster': _$ClusterEnumMap[instance.cluster]!,
    };

const _$ClusterEnumMap = {
  Cluster.mainnet: 'mainnet',
  Cluster.devnet: 'devnet',
};

_$_CreatePaymentResponseDto _$$_CreatePaymentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CreatePaymentResponseDto(
      transaction: json['transaction'] as String,
      slot: BigInt.parse(json['slot'] as String),
    );

Map<String, dynamic> _$$_CreatePaymentResponseDtoToJson(
        _$_CreatePaymentResponseDto instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'slot': instance.slot.toString(),
    };

_$_ReceivePaymentRequestDto _$$_ReceivePaymentRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_ReceivePaymentRequestDto(
      receiverAccount: json['receiverAccount'] as String,
      escrowAccount: json['escrowAccount'] as String,
      cluster: $enumDecode(_$ClusterEnumMap, json['cluster']),
    );

Map<String, dynamic> _$$_ReceivePaymentRequestDtoToJson(
        _$_ReceivePaymentRequestDto instance) =>
    <String, dynamic>{
      'receiverAccount': instance.receiverAccount,
      'escrowAccount': instance.escrowAccount,
      'cluster': _$ClusterEnumMap[instance.cluster]!,
    };

_$_ReceivePaymentResponseDto _$$_ReceivePaymentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_ReceivePaymentResponseDto(
      transaction: json['transaction'] as String,
      slot: BigInt.parse(json['slot'] as String),
    );

Map<String, dynamic> _$$_ReceivePaymentResponseDtoToJson(
        _$_ReceivePaymentResponseDto instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'slot': instance.slot.toString(),
    };

_$_CreateDirectPaymentRequestDto _$$_CreateDirectPaymentRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CreateDirectPaymentRequestDto(
      senderAccount: json['senderAccount'] as String,
      receiverAccount: json['receiverAccount'] as String,
      referenceAccount: json['referenceAccount'] as String?,
      amount: json['amount'] as int,
      cluster: $enumDecode(_$ClusterEnumMap, json['cluster']),
    );

Map<String, dynamic> _$$_CreateDirectPaymentRequestDtoToJson(
        _$_CreateDirectPaymentRequestDto instance) =>
    <String, dynamic>{
      'senderAccount': instance.senderAccount,
      'receiverAccount': instance.receiverAccount,
      'referenceAccount': instance.referenceAccount,
      'amount': instance.amount,
      'cluster': _$ClusterEnumMap[instance.cluster]!,
    };

_$_CreateDirectPaymentResponseDto _$$_CreateDirectPaymentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CreateDirectPaymentResponseDto(
      fee: json['fee'] as int,
      transaction: json['transaction'] as String,
      slot: BigInt.parse(json['slot'] as String),
    );

Map<String, dynamic> _$$_CreateDirectPaymentResponseDtoToJson(
        _$_CreateDirectPaymentResponseDto instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'transaction': instance.transaction,
      'slot': instance.slot.toString(),
    };

_$_CancelPaymentRequestDto _$$_CancelPaymentRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CancelPaymentRequestDto(
      senderAccount: json['senderAccount'] as String,
      escrowAccount: json['escrowAccount'] as String,
      cluster: $enumDecode(_$ClusterEnumMap, json['cluster']),
    );

Map<String, dynamic> _$$_CancelPaymentRequestDtoToJson(
        _$_CancelPaymentRequestDto instance) =>
    <String, dynamic>{
      'senderAccount': instance.senderAccount,
      'escrowAccount': instance.escrowAccount,
      'cluster': _$ClusterEnumMap[instance.cluster]!,
    };

_$_CancelPaymentResponseDto _$$_CancelPaymentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CancelPaymentResponseDto(
      transaction: json['transaction'] as String,
      slot: BigInt.parse(json['slot'] as String),
    );

Map<String, dynamic> _$$_CancelPaymentResponseDtoToJson(
        _$_CancelPaymentResponseDto instance) =>
    <String, dynamic>{
      'transaction': instance.transaction,
      'slot': instance.slot.toString(),
    };
