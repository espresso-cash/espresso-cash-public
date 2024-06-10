// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'durable_transactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetFreeNonceResponseDtoImpl _$$GetFreeNonceResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$GetFreeNonceResponseDtoImpl(
      nonce: json['nonce'] as String,
      nonceAccount: json['nonceAccount'] as String,
      authority: json['authority'] as String,
    );

Map<String, dynamic> _$$GetFreeNonceResponseDtoImplToJson(
        _$GetFreeNonceResponseDtoImpl instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'nonceAccount': instance.nonceAccount,
      'authority': instance.authority,
    };

_$SubmitDurableTxRequestDtoImpl _$$SubmitDurableTxRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$SubmitDurableTxRequestDtoImpl(
      tx: json['tx'] as String,
    );

Map<String, dynamic> _$$SubmitDurableTxRequestDtoImplToJson(
        _$SubmitDurableTxRequestDtoImpl instance) =>
    <String, dynamic>{
      'tx': instance.tx,
    };

_$SubmitDurableTxResponseDtoImpl _$$SubmitDurableTxResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$SubmitDurableTxResponseDtoImpl(
      signature: json['signature'] as String,
    );

Map<String, dynamic> _$$SubmitDurableTxResponseDtoImplToJson(
        _$SubmitDurableTxResponseDtoImpl instance) =>
    <String, dynamic>{
      'signature': instance.signature,
    };

_$GetDurableFeesResponseDtoImpl _$$GetDurableFeesResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$GetDurableFeesResponseDtoImpl(
      outgoingLink: (json['outgoingLink'] as num).toInt(),
      incomingLink: (json['incomingLink'] as num).toInt(),
      cancelLink: (json['cancelLink'] as num).toInt(),
    );

Map<String, dynamic> _$$GetDurableFeesResponseDtoImplToJson(
        _$GetDurableFeesResponseDtoImpl instance) =>
    <String, dynamic>{
      'outgoingLink': instance.outgoingLink,
      'incomingLink': instance.incomingLink,
      'cancelLink': instance.cancelLink,
    };
