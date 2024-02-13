import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

import '../../../config.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../authenticated/auth_scope.dart';

@Singleton(scope: authScope)
class IntercomService implements Disposable {
  IntercomService._() {
    init();
  }

  static IntercomService? _instance;

  Future<void> init() async {
    await Intercom.instance.initialize(
      intercomAppId,
      iosApiKey: intercomIosKey,
      androidApiKey: intercomAndroidKey,
    );
  }

  @FactoryMethod(preResolve: true)
  static Future<IntercomService> create(ECWallet account) async {
    final IntercomService instance = _instance ??= IntercomService._();

    await Intercom.instance.loginIdentifiedUser(userId: account.address);

    return instance;
  }

  Future<void> displayMessenger() => Intercom.instance.displayMessenger();

  void updateCountry(String? countryCode) => Intercom.instance
      .updateUser(customAttributes: {'countryCode': countryCode});

  @override
  Future<void> onDispose() => Intercom.instance.logout();
}
