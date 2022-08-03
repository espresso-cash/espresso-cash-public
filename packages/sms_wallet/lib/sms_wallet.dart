
import 'sms_wallet_platform_interface.dart';

class SmsWallet {
  Future<String?> getPlatformVersion() {
    return SmsWalletPlatform.instance.getPlatformVersion();
  }
}
