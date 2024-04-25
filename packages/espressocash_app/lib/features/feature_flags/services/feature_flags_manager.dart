import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@singleton
class FeatureFlagsManager {
  final _remoteConfig = FirebaseRemoteConfig.instance;

  @PostConstruct(preResolve: true)
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

  bool isOutgoingDlnEnabled() =>
      _remoteConfig.getBool(FeatureFlag.outgoingDln.name);

  bool isIncomingDlnEnabled() =>
      _remoteConfig.getBool(FeatureFlag.incomingDln.name);

  bool isTransactionRequestEnabled() =>
      _remoteConfig.getBool(FeatureFlag.transactionRequest.name);
}

enum FeatureFlag { outgoingDln, incomingDln, transactionRequest }
