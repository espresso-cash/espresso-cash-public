import 'package:flutter/foundation.dart';
import 'package:solana_seed_vault/src/api.dart';

class SeedVault {
  @visibleForTesting
  SeedVault(this._platform);

  SeedVault._(this._platform);

  final SeedVaultApiHost _platform;

  static var _instance = SeedVault._(SeedVaultApiHost());

  static SeedVault get instance => _instance;

  @visibleForTesting
  static set instance(SeedVault seedVault) => _instance = seedVault;

  Future<bool> isAvailable(bool allowSimulated) =>
      _platform.isAvailable(allowSimulated);

  Future<bool> checkPermission() => _platform.checkPermission();
}
