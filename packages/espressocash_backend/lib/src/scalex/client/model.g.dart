// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GenerateIFrameBodyDto _$$_GenerateIFrameBodyDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GenerateIFrameBodyDto(
      type: json['type'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      network: json['network'] as String,
    );

Map<String, dynamic> _$$_GenerateIFrameBodyDtoToJson(
        _$_GenerateIFrameBodyDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'address': instance.address,
      'email': instance.email,
      'token': instance.token,
      'network': instance.network,
    };

_$_ScalexResponseDto<T> _$$_ScalexResponseDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$_ScalexResponseDto<T>(
      data: fromJsonT(json['data']),
    );

_$_GenerateIFrameResponseDto _$$_GenerateIFrameResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GenerateIFrameResponseDto(
      link: json['link'] as String,
      environment: json['environment'] as String,
    );

Map<String, dynamic> _$$_GenerateIFrameResponseDtoToJson(
        _$_GenerateIFrameResponseDto instance) =>
    <String, dynamic>{
      'link': instance.link,
      'environment': instance.environment,
    };

_$_TransactionDto _$$_TransactionDtoFromJson(Map<String, dynamic> json) =>
    _$_TransactionDto(
      status: $enumDecode(_$OrderStatusEnumMap, json['status'],
          unknownValue: OrderStatus.unknown),
      type: json['type'] as String,
      fromCurrency: json['from_currency'] as String,
      fromAmount: json['from_amount'] as num,
      bankToFund: json['bank_to_fund'] == null
          ? null
          : BankInfoDto.fromJson(json['bank_to_fund'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TransactionDtoToJson(_$_TransactionDto instance) =>
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

_$_PaymentDto _$$_PaymentDtoFromJson(Map<String, dynamic> json) =>
    _$_PaymentDto(
      bankName: json['bank_name'] as String,
      accountNumber: json['account_number'] as String,
    );

Map<String, dynamic> _$$_PaymentDtoToJson(_$_PaymentDto instance) =>
    <String, dynamic>{
      'bank_name': instance.bankName,
      'account_number': instance.accountNumber,
    };
