// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WithdrawPaymentRequestDtoImpl _$$WithdrawPaymentRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$WithdrawPaymentRequestDtoImpl(
      senderAccount: json['senderAccount'] as String,
      receiverAccount: json['receiverAccount'] as String,
      amount: json['amount'] as int,
      feePercentage: json['feePercentage'] as int,
      cluster: $enumDecode(_$ClusterEnumMap, json['cluster']),
    );

Map<String, dynamic> _$$WithdrawPaymentRequestDtoImplToJson(
        _$WithdrawPaymentRequestDtoImpl instance) =>
    <String, dynamic>{
      'senderAccount': instance.senderAccount,
      'receiverAccount': instance.receiverAccount,
      'amount': instance.amount,
      'feePercentage': instance.feePercentage,
      'cluster': _$ClusterEnumMap[instance.cluster]!,
    };

const _$ClusterEnumMap = {
  Cluster.mainnet: 'mainnet',
  Cluster.devnet: 'devnet',
};

_$WithdrawPaymentResponseDtoImpl _$$WithdrawPaymentResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$WithdrawPaymentResponseDtoImpl(
      fee: json['fee'] as int,
      transaction: json['transaction'] as String,
      slot: BigInt.parse(json['slot'] as String),
    );

Map<String, dynamic> _$$WithdrawPaymentResponseDtoImplToJson(
        _$WithdrawPaymentResponseDtoImpl instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'transaction': instance.transaction,
      'slot': instance.slot.toString(),
    };
