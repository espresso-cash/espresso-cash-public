import 'package:injectable/injectable.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

import '../config.dart';

@singleton
class IntercomService {
  IntercomService() {
    _init();
  }

  final _intercom = Intercom.instance;

  Future<void> _init() async {
    await _intercom.initialize(
      intercomAppId,
      iosApiKey: intercomIosKey,
      androidApiKey: intercomAndroidKey,
    );

    await _intercom.loginUnidentifiedUser();
  }

  void logout() => _intercom.logout();

  Future<void> displayMessenger() => _intercom.displayMessenger();
}
