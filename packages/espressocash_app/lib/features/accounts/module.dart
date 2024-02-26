import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../core/callback.dart';
import '../../core/extensions.dart';
import '../../di.dart';
import 'models/account.dart';
import 'models/ec_wallet.dart';
import 'services/account_service.dart';
import 'widgets/account_listener.dart';

class AccountsModule extends SingleChildStatelessWidget {
  const AccountsModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      SeedVaultListener(
        onDeauthorized: () => sl<AccountService>().logOut(),
        child: child,
      );
}

class LogoutListener extends SingleChildStatefulWidget {
  const LogoutListener({
    super.key,
    super.child,
    required this.onLogout,
  });

  final Callback1<BuildContext> onLogout;

  @override
  State<StatefulWidget> createState() => _LogoutListenerState();
}

class _LogoutListenerState extends SingleChildState<LogoutListener>
    with AccountListener {
  @override
  void handleAccountChanged(MyAccount? account) {
    if (account == null) {
      widget.onLogout(context);
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      child ?? const SizedBox.shrink();
}

/// In case of a Saga Wallet, this component will notify if the Seed Vault
/// deauthorizes the app.
class SeedVaultListener extends SingleChildStatefulWidget {
  const SeedVaultListener({
    super.key,
    super.child,
    required this.onDeauthorized,
  });

  final VoidCallback onDeauthorized;

  @override
  State<StatefulWidget> createState() => _SeedVaultListenerState();
}

class _SeedVaultListenerState extends SingleChildState<SeedVaultListener>
    with AccountListener {
  StreamSubscription<SeedVaultNotification>? _subscription;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _onNotification(
    SeedVaultNotification event,
    SagaWallet wallet,
  ) async {
    if (event.uris.toSet().intersection(_affectedUris).isEmpty) return;

    final accountExistsAndIsAuthorized =
        await sl<SeedVault>().hasAccessToAccount(wallet.token, wallet.account);

    if (!accountExistsAndIsAuthorized) widget.onDeauthorized();
  }

  @override
  void handleAccountChanged(MyAccount? account) {
    _subscription?.cancel();

    final sagaWallet =
        account?.wallet.let((it) => it is SagaWallet ? it : null);

    if (sagaWallet == null) return;

    _subscription = sl<SeedVault>()
        .notificationStream
        .listen((event) => _onNotification(event, sagaWallet));
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      child ?? const SizedBox.shrink();
}

final _affectedUris = WalletContractV1().let(
  (it) => {
    it.unauthorizedSeedsContentUri,
    it.accountsContentUri,
  },
);
