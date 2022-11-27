import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_config.g.dart';
part 'wallet_config.freezed.dart';

@freezed
class MobileWalletAdapterConfig with _$MobileWalletAdapterConfig {
  const factory MobileWalletAdapterConfig({
    required bool supportsSignAndSendTransactions,
    required int maxTransactionsPerSigningRequest,
    required int maxMessagesPerSigningRequest,
    required List<Object> supportedTransactionVersions,
  }) = _MobileWalletAdapterConfig;

  factory MobileWalletAdapterConfig.fromJson(Map<String, dynamic> json) =>
      _$MobileWalletAdapterConfigFromJson(json);
}
