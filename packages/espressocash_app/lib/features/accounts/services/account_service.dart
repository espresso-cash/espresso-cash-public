import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../di.config.dart';
import '../../../di.dart';
import '../../analytics/analytics_manager.dart';
import '../auth_scope.dart';
import '../data/account_repository.dart';
import '../models/account.dart';
import '../models/mnemonic.dart';

@Singleton()
class AccountService extends ChangeNotifier
    implements ValueListenable<MyAccount?> {
  AccountService(
    this._repository,
    this._analyticsManager,
    this._storage,
  );

  final AccountRepository _repository;
  final AnalyticsManager _analyticsManager;
  final FlutterSecureStorage _storage;

  MyAccount? _value;

  @override
  MyAccount? get value => _value;

  void _update(MyAccount? value) {
    if (value == _value) return;

    _value = value;
    notifyListeners();
  }

  Future<void> initialize([ISentrySpan? span]) async {
    final spanLoadingAccount = span?.startChild('Loading account');
    final account = await _repository.loadAccount();
    await spanLoadingAccount?.finish();
    if (account != null) {
      final spanProcessingLogIn = span?.startChild('Processing log in');
      await _processLogIn(account);
      await spanProcessingLogIn?.finish();
    }
  }

  Future<void> logIn({
    required AccountSource source,
    required MyAccount account,
  }) async {
    await _repository.saveAccountSource(source);
    await _processLogIn(account);
  }

  Future<void> logOut() async {
    if (_value == null) return;

    _analyticsManager.setWalletAddress(null);
    Sentry.configureScope((scope) => scope.removeExtra('walletAddress'));

    await _storage.deleteAll();
    await sl.dropScope(authScope);

    _update(null);
  }

  Future<void> _processLogIn(MyAccount account) async {
    Sentry.configureScope(
      (scope) => scope.setExtra('walletAddress', account.address),
    );
    _analyticsManager.setWalletAddress(account.address);

    _value = account;
    await sl.initAuthScope();
    notifyListeners();
  }
}
