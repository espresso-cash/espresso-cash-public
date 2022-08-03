import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sms_wallet_method_channel.dart';

abstract class SmsWalletPlatform extends PlatformInterface {
  /// Constructs a SmsWalletPlatform.
  SmsWalletPlatform() : super(token: _token);

  static final Object _token = Object();

  static SmsWalletPlatform _instance = MethodChannelSmsWallet();

  /// The default instance of [SmsWalletPlatform] to use.
  ///
  /// Defaults to [MethodChannelSmsWallet].
  static SmsWalletPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SmsWalletPlatform] when
  /// they register themselves.
  static set instance(SmsWalletPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
