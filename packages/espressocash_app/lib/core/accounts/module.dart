import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../di.dart';
import '../callback.dart';
import 'bl/account.dart';
import 'bl/accounts_bloc.dart';
import 'bl/ec_wallet.dart';

class AccountsModule extends SingleChildStatelessWidget {
  const AccountsModule({Key? key, Widget? child})
      : super(key: key, child: child);

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
    Key? key,
    Widget? child,
    required this.onLogout,
  }) : super(key: key, child: child);

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
    Key? key,
    Widget? child,
    required this.onDeauthorized,
  }) : super(key: key, child: child);

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

    if (account == null) return;

    final affectedUri = account.wallet
        .let((it) => it is SagaWallet ? it : null)
        .maybeFlatMap((it) => it.token.toString())
        .maybeFlatMap(WalletContractV1().authorizedSeedsContentUri.append);

    if (affectedUri == null) return;

    _subscription = sl<SeedVault>()
        .notificationStream
        .listen((event) => _onNotification(event, affectedUri));
  }

  void _onNotification(SeedVaultNotification event, Uri uri) {
    if (!event.uris.contains(uri)) return;
    widget.onDeauthorized();
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocListener<AccountsBloc, AccountsState>(
        listenWhen: (prev, cur) => prev.account != cur.account,
        listener: (_, state) => _onUpdateAccount(state.account),
        child: child,
      );
}

extension on Uri {
  Uri append(String segment) => replace(
        pathSegments: pathSegments.toIList().add(segment),
      );
}
