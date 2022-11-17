import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FeatureFlagsManager {
  FeatureFlagsManager() {
    _init();
  }

  final _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> _init() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await _remoteConfig.fetchAndActivate();
  }

  bool get isTransactionsTabEnabled =>
      _remoteConfig.getBool(FeatureFlag.isTransactionsTabEnabled.name);
}

enum FeatureFlag { isTransactionsTabEnabled }
