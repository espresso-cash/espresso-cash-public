
import 'solana_seed_vault_platform_interface.dart';

class SolanaSeedVault {
  Future<String?> getPlatformVersion() {
    return SolanaSeedVaultPlatform.instance.getPlatformVersion();
  }
}
