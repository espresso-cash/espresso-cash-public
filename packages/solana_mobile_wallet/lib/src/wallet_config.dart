import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_config.freezed.dart';

@freezed
class MobileWalletAdapterConfig with _$MobileWalletAdapterConfig {
  const factory MobileWalletAdapterConfig({
    required bool supportsSignAndSendTransactions,
    required int maxTransactionsPerSigningRequest,
    required int maxMessagesPerSigningRequest,
    required List<Object> supportedTransactionVersions,
    @Default(Duration(seconds: 3)) Duration noConnectionWarningTimeout,
  }) = _MobileWalletAdapterConfig;
}
