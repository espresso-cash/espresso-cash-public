// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenerateIFrameBodyDtoImpl _$$GenerateIFrameBodyDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$GenerateIFrameBodyDtoImpl(
      type: json['type'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      network: json['network'] as String,
    );

Map<String, dynamic> _$$GenerateIFrameBodyDtoImplToJson(
        _$GenerateIFrameBodyDtoImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'address': instance.address,
      'email': instance.email,
      'token': instance.token,
      'network': instance.network,
    };

_$ScalexResponseDtoImpl<T> _$$ScalexResponseDtoImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$ScalexResponseDtoImpl<T>(
      data: fromJsonT(json['data']),
    );

_$GenerateIFrameResponseDtoImpl _$$GenerateIFrameResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$GenerateIFrameResponseDtoImpl(
      link: json['link'] as String,
      environment: json['environment'] as String,
    );

Map<String, dynamic> _$$GenerateIFrameResponseDtoImplToJson(
        _$GenerateIFrameResponseDtoImpl instance) =>
    <String, dynamic>{
      'link': instance.link,
      'environment': instance.environment,
    };

_$TransactionDtoImpl _$$TransactionDtoImplFromJson(Map<String, dynamic> json) =>
    _$TransactionDtoImpl(
      status: $enumDecode(_$OrderStatusEnumMap, json['status'],
          unknownValue: OrderStatus.unknown),
      type: json['type'] as String,
      fromCurrency: json['from_currency'] as String,
      fromAmount: json['from_amount'] as num,
      bankToFund: json['bank_to_fund'] == null
          ? null
          : BankInfoDto.fromJson(json['bank_to_fund'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TransactionDtoImplToJson(
        _$TransactionDtoImpl instance) =>
    <String, dynamic>{
      'status': _$OrderStatusEnumMap[instance.status]!,
      'type': instance.type,
      'from_currency': instance.fromCurrency,
      'from_amount': instance.fromAmount,
      'bank_to_fund': instance.bankToFund,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.completed: 'completed',
  OrderStatus.expired: 'expired',
  OrderStatus.failed: 'failed',
  OrderStatus.unknown: 'unknown',
};

_$PaymentDtoImpl _$$PaymentDtoImplFromJson(Map<String, dynamic> json) =>
    _$PaymentDtoImpl(
      bankName: json['bank_name'] as String,
      accountNumber: json['account_number'] as String,
    );

Map<String, dynamic> _$$PaymentDtoImplToJson(_$PaymentDtoImpl instance) =>
    <String, dynamic>{
      'bank_name': instance.bankName,
      'account_number': instance.accountNumber,
    };
