import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sms_wallet_platform_interface.dart';

/// An implementation of [SmsWalletPlatform] that uses method channels.
class MethodChannelSmsWallet extends SmsWalletPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sms_wallet');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
