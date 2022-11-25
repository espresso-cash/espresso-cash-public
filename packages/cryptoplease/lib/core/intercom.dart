import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:nested/nested.dart';

import '../config.dart';
import '../di.dart';
import 'accounts/module.dart';

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

    login();
  }

  void login() => _intercom.loginUnidentifiedUser();

  void logout() => _intercom.logout();

  Future<void> displayMessenger() => _intercom.displayMessenger();
}

class IntercomModule extends SingleChildStatelessWidget {
  const IntercomModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => LogoutListener(
        onLogout: (_) => sl<IntercomService>().logout(),
        child: child,
      );
}
