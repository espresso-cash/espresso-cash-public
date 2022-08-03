import 'package:flutter_test/flutter_test.dart';
import 'package:sms_wallet/sms_wallet.dart';
import 'package:sms_wallet/sms_wallet_platform_interface.dart';
import 'package:sms_wallet/sms_wallet_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSmsWalletPlatform 
    with MockPlatformInterfaceMixin
    implements SmsWalletPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SmsWalletPlatform initialPlatform = SmsWalletPlatform.instance;

  test('$MethodChannelSmsWallet is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSmsWallet>());
  });

  test('getPlatformVersion', () async {
    SmsWallet smsWalletPlugin = SmsWallet();
    MockSmsWalletPlatform fakePlatform = MockSmsWalletPlatform();
    SmsWalletPlatform.instance = fakePlatform;
  
    expect(await smsWalletPlugin.getPlatformVersion(), '42');
  });
}
