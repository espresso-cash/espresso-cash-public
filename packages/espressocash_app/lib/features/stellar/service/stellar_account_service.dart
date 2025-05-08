import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../accounts/auth_scope.dart';
import '../../analytics/analytics_manager.dart';
import '../../intercom/services/intercom_service.dart';
import '../models/stellar_wallet.dart';

@Singleton(scope: authScope)
class StellarAccountService {
  const StellarAccountService(this._stellarWallet, this._analyticsManager);

  final StellarWallet _stellarWallet;
  final AnalyticsManager _analyticsManager;

  @postConstruct
  void init() {
    final address = _stellarWallet.address;

    Sentry.configureScope((scope) => scope.setContexts('stellarWalletAddress', address));
    _analyticsManager.setStellarAddress(address);
    IntercomService.updateStellarAddress(address);
  }

  @disposeMethod
  static void dispose() {
    Sentry.configureScope((scope) => scope.removeContexts('stellarWalletAddress'));
  }
}
