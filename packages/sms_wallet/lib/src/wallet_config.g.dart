// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileWalletAdapterConfig _$MobileWalletAdapterConfigFromJson(
        Map<String, dynamic> json) =>
    MobileWalletAdapterConfig(
      supportsSignAndSendTransactions:
          json['supportsSignAndSendTransactions'] as bool,
      maxTransactionsPerSigningRequest:
          json['maxTransactionsPerSigningRequest'] as int,
      maxMessagesPerSigningRequest: json['maxMessagesPerSigningRequest'] as int,
    );

Map<String, dynamic> _$MobileWalletAdapterConfigToJson(
        MobileWalletAdapterConfig instance) =>
    <String, dynamic>{
      'supportsSignAndSendTransactions':
          instance.supportsSignAndSendTransactions,
      'maxTransactionsPerSigningRequest':
          instance.maxTransactionsPerSigningRequest,
      'maxMessagesPerSigningRequest': instance.maxMessagesPerSigningRequest,
    };
