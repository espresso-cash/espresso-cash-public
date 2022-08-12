// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MobileWalletAdapterConfig _$$_MobileWalletAdapterConfigFromJson(
        Map<String, dynamic> json) =>
    _$_MobileWalletAdapterConfig(
      supportsSignAndSendTransactions:
          json['supportsSignAndSendTransactions'] as bool,
      maxTransactionsPerSigningRequest:
          json['maxTransactionsPerSigningRequest'] as int,
      maxMessagesPerSigningRequest: json['maxMessagesPerSigningRequest'] as int,
    );

Map<String, dynamic> _$$_MobileWalletAdapterConfigToJson(
        _$_MobileWalletAdapterConfig instance) =>
    <String, dynamic>{
      'supportsSignAndSendTransactions':
          instance.supportsSignAndSendTransactions,
      'maxTransactionsPerSigningRequest':
          instance.maxTransactionsPerSigningRequest,
      'maxMessagesPerSigningRequest': instance.maxMessagesPerSigningRequest,
    };
