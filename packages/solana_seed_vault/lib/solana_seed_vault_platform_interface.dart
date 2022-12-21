import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'solana_seed_vault_method_channel.dart';

abstract class SolanaSeedVaultPlatform extends PlatformInterface {
  /// Constructs a SolanaSeedVaultPlatform.
  SolanaSeedVaultPlatform() : super(token: _token);

  static final Object _token = Object();

  static SolanaSeedVaultPlatform _instance = MethodChannelSolanaSeedVault();

  /// The default instance of [SolanaSeedVaultPlatform] to use.
  ///
  /// Defaults to [MethodChannelSolanaSeedVault].
  static SolanaSeedVaultPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SolanaSeedVaultPlatform] when
  /// they register themselves.
  static set instance(SolanaSeedVaultPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
