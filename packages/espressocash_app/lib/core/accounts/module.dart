import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../di.dart';
import '../callback.dart';
import '../extensions.dart';
import 'bl/account.dart';
import 'bl/accounts_bloc.dart';
import 'bl/ec_wallet.dart';

class AccountsModule extends SingleChildStatelessWidget {
  const AccountsModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (context) =>
            sl<AccountsBloc>()..add(const AccountsEvent.initialize()),
        child: Builder(
          builder: (context) => SeedVaultListener(
            onDeauthorized: () => context
                .read<AccountsBloc>()
                .add(const AccountsEvent.loggedOut()),
            child: child,
          ),
        ),
      );
}

class LogoutListener extends SingleChildStatelessWidget {
  const LogoutListener({
    super.key,
    super.child,
    required this.onLogout,
  });

  final Callback1<BuildContext> onLogout;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocListener<AccountsBloc, AccountsState>(
        listenWhen: (s1, s2) => s1.account != s2.account,
        listener: (context, state) {
          if (state.account == null) {
            onLogout(context);
          }
        },
        child: child,
      );
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

class _SeedVaultListenerState extends SingleChildState<SeedVaultListener> {
  StreamSubscription<SeedVaultNotification>? _subscription;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _onUpdateAccount(MyAccount? account) {
    _subscription?.cancel();

    final sagaWallet =
        account?.wallet.let((it) => it is SagaWallet ? it : null);

    if (sagaWallet == null) return;

    _subscription = sl<SeedVault>()
        .notificationStream
        .listen((event) => _onNotification(event, sagaWallet));
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
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocListener<AccountsBloc, AccountsState>(
        listenWhen: (prev, cur) => prev.account != cur.account,
        listener: (_, state) => _onUpdateAccount(state.account),
        child: child,
      );
}

final _affectedUris = WalletContractV1().let(
  (it) => {
    it.unauthorizedSeedsContentUri,
    it.accountsContentUri,
  },
);
