import 'package:flutter/services.dart';
import 'package:solana_mobile_wallet/src/auth_issuer_config.dart';
import 'package:solana_mobile_wallet/src/wallet_config.dart';

class SmsWalletPlatform {
  SmsWalletPlatform._();

  static final SmsWalletPlatform _instance = SmsWalletPlatform._();

  static SmsWalletPlatform get instance => _instance;

  final MethodChannel _methodChannel =
      const MethodChannel('com.solana.sms.wallet');

  Future<Uint8List?> createScenario({
    required MobileWalletAdapterConfig walletConfig,
    required AuthIssuerConfig issuerConfig,
    required int id,
  }) async =>
      _methodChannel
          .invokeMethod<Uint8List>('createScenario', <String, dynamic>{
        'walletConfig': walletConfig.toJson(),
        'issuerConfig': issuerConfig.toJson(),
        'id': id
      });
}
