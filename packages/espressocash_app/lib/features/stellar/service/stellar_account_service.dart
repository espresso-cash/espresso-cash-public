import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../accounts/auth_scope.dart';
import '../../analytics/analytics_manager.dart';
import '../models/stellar_wallet.dart';

@Singleton(scope: authScope)
class StellarAccountService {
  const StellarAccountService(this._stellarWallet, this._analyticsManager);

  final StellarWallet _stellarWallet;
  final AnalyticsManager _analyticsManager;

  @postConstruct
  void init() {
    final address = _stellarWallet.address;

    Sentry.configureScope(
      (scope) => scope.setExtra('stellarWalletAddress', address),
    );
    _analyticsManager.setStellarAddress(address);
  }

  @disposeMethod
  void dispose() {
    Sentry.configureScope((scope) => scope.removeExtra('stellarWalletAddress'));
  }
}
