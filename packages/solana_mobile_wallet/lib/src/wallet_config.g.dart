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
      supportedTransactionVersions:
          (json['supportedTransactionVersions'] as List<dynamic>)
              .map((e) => e as Object)
              .toList(),
      noConnectionWarningTimeout: json['noConnectionWarningTimeout'] == null
          ? const Duration(seconds: 3)
          : Duration(microseconds: json['noConnectionWarningTimeout'] as int),
    );

Map<String, dynamic> _$$_MobileWalletAdapterConfigToJson(
        _$_MobileWalletAdapterConfig instance) =>
    <String, dynamic>{
      'supportsSignAndSendTransactions':
          instance.supportsSignAndSendTransactions,
      'maxTransactionsPerSigningRequest':
          instance.maxTransactionsPerSigningRequest,
      'maxMessagesPerSigningRequest': instance.maxMessagesPerSigningRequest,
      'supportedTransactionVersions': instance.supportedTransactionVersions,
      'noConnectionWarningTimeout':
          instance.noConnectionWarningTimeout.inMicroseconds,
    };
