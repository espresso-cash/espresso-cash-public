import 'package:json_annotation/json_annotation.dart';

part 'wallet_config.g.dart';

@JsonSerializable()
class MobileWalletAdapterConfig {
  const MobileWalletAdapterConfig({
    required this.supportsSignAndSendTransactions,
    required this.maxTransactionsPerSigningRequest,
    required this.maxMessagesPerSigningRequest,
  });

  factory MobileWalletAdapterConfig.fromJson(Map<String, dynamic> json) =>
      _$MobileWalletAdapterConfigFromJson(json);

  Map<String, dynamic> toJson() => _$MobileWalletAdapterConfigToJson(this);

  final bool supportsSignAndSendTransactions;
  final int maxTransactionsPerSigningRequest;
  final int maxMessagesPerSigningRequest;
}
