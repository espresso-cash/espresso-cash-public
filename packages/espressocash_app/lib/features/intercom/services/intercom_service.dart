import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

import '../../../config.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';

@Singleton(scope: authScope)
class IntercomService implements Disposable {
  const IntercomService._();

  static IntercomService? _instance;

  @FactoryMethod(preResolve: true)
  static Future<IntercomService> create(ECWallet account) async {
    if (_instance == null) {
      await Intercom.instance.initialize(
        intercomAppId,
        iosApiKey: intercomIosKey,
        androidApiKey: intercomAndroidKey,
      );
    }

    final IntercomService instance = _instance ??= const IntercomService._();

    unawaited(Intercom.instance.loginIdentifiedUser(userId: account.address));

    return instance;
  }

  Future<void> displayMessenger() => Intercom.instance.displayMessenger();

  void updateCountry(String? countryCode) => Intercom.instance
      .updateUser(customAttributes: {'countryCode': countryCode});

  @override
  Future<void> onDispose() => Intercom.instance.logout();
}
