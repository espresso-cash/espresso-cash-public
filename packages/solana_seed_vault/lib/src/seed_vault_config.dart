import 'package:flutter/foundation.dart';
import 'package:solana_seed_vault/src/api.dart';

class SeedVaultConfig {
  @visibleForTesting
  SeedVaultConfig(this._platform);

  SeedVaultConfig._(this._platform);

  final SeedVaultApiHost _platform;

  static var _instance = SeedVaultConfig._(SeedVaultApiHost());

  static SeedVaultConfig get instance => _instance;

  @visibleForTesting
  static set instance(SeedVaultConfig seedVault) => _instance = seedVault;

  Future<bool> isAvailable(bool allowSimulated) =>
      _platform.isAvailable(allowSimulated);

  Future<bool> checkPermission() => _platform.checkPermission();
}
