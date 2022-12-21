import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'solana_seed_vault_platform_interface.dart';

/// An implementation of [SolanaSeedVaultPlatform] that uses method channels.
class MethodChannelSolanaSeedVault extends SolanaSeedVaultPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('solana_seed_vault');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
