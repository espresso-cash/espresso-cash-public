import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@singleton
class FeatureFlagsManager implements Disposable {
  FeatureFlagsManager() {
    _init();
  }

  final _remoteConfig = FirebaseRemoteConfig.instance;

  StreamSubscription<void>? _subscription;

  Future<void> _init() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await _remoteConfig.fetchAndActivate();
    _subscription =
        _remoteConfig.onConfigUpdated.listen((_) => _remoteConfig.activate());
  }

  bool isMoneygramAccessEnabled() =>
      _remoteConfig.getBool(FeatureFlag.moneygram.name);

  @override
  void onDispose() {
    _subscription?.cancel();
  }
}

enum FeatureFlag { moneygram }
