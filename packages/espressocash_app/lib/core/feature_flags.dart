import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@singleton
class FeatureFlagsManager {
  final _remoteConfig = FirebaseRemoteConfig.instance;

  @PostConstruct()
  Future<void> init() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await _remoteConfig.fetchAndActivate();
    } on Object {
      // ignore
    }
  }

  bool get isUniversalPayEnabled =>
      _remoteConfig.getBool(FeatureFlag.universalPay.name);

  bool get isCrossChainPaymentsEnabled =>
      _remoteConfig.getBool(FeatureFlag.crossChainPayments.name);

  bool get isOffRampEnabled => _remoteConfig.getBool(FeatureFlag.offRamp.name);
}

enum FeatureFlag { universalPay, crossChainPayments, offRamp }
