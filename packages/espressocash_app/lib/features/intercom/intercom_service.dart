import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

import '../../../config.dart';
import '../accounts/models/ec_wallet.dart';
import '../authenticated/auth_scope.dart';

@Singleton(scope: authScope)
class IntercomService implements Disposable {
  IntercomService(this._account);

  final ECWallet _account;

  final _intercom = Intercom.instance;

  Future<void> displayMessenger() => _intercom.displayMessenger();

  void updateCountry(String? countryCode) {
    _intercom.updateUser(customAttributes: {'countryCode': countryCode});
  }

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    await _intercom.initialize(
      intercomAppId,
      iosApiKey: intercomIosKey,
      androidApiKey: intercomAndroidKey,
    );
    await _intercom.loginIdentifiedUser(userId: _account.address);
  }

  @override
  Future<void> onDispose() async {
    await _intercom.logout();
  }
}
