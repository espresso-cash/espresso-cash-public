import 'package:injectable/injectable.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

import '../../../config.dart';

@lazySingleton
class IntercomService {
  late final Future<void> _init = _intercom.initialize(
    intercomAppId,
    iosApiKey: intercomIosKey,
    androidApiKey: intercomAndroidKey,
  );

  final _intercom = Intercom.instance;

  Future<void> login() async {
    await _init;
    await _intercom.loginUnidentifiedUser();
  }

  void logout() => _intercom.logout();

  Future<void> displayMessenger() => _intercom.displayMessenger();
}
