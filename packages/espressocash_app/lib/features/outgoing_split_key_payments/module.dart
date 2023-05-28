import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/accounts/module.dart';
import '../../core/balances/context_ext.dart';
import '../../di.dart';
import 'src/bl/cancel_tx_created_watcher.dart';
import 'src/bl/cancel_tx_sent_watcher.dart';
import 'src/bl/repository.dart';
import 'src/bl/tx_confirmed_watcher.dart';
import 'src/bl/tx_created_watcher.dart';
import 'src/bl/tx_ready_watcher.dart';
import 'src/bl/tx_sent_watcher.dart';

class OSKPModule extends SingleChildStatelessWidget {
  const OSKPModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<TxReadyWatcher>(
            lazy: false,
            create: (context) => sl<TxReadyWatcher>(
              param1: context.read<MyAccount>().wallet.publicKey,
            )..init(onBalanceAffected: () => context.notifyBalanceAffected()),
            dispose: (_, value) => value.dispose(),
          ),
          Provider<TxConfirmedWatcher>(
            lazy: false,
            create: (context) => sl<TxConfirmedWatcher>()
              ..call(onBalanceAffected: () => context.notifyBalanceAffected()),
            dispose: (_, value) => value.dispose(),
          ),
          Provider<TxCreatedWatcher>(
            lazy: false,
            create: (context) => sl<TxCreatedWatcher>()
              ..call(onBalanceAffected: () => context.notifyBalanceAffected()),
            dispose: (_, value) => value.dispose(),
          ),
          Provider<TxSentWatcher>(
            lazy: false,
            create: (context) => sl<TxSentWatcher>()
              ..call(onBalanceAffected: () => context.notifyBalanceAffected()),
            dispose: (_, value) => value.dispose(),
          ),
          Provider<CancelTxCreatedWatcher>(
            lazy: false,
            create: (context) => sl<CancelTxCreatedWatcher>()
              ..call(onBalanceAffected: () => context.notifyBalanceAffected()),
            dispose: (_, value) => value.dispose(),
          ),
          Provider<CancelTxSentWatcher>(
            lazy: false,
            create: (context) => sl<CancelTxSentWatcher>()
              ..call(onBalanceAffected: () => context.notifyBalanceAffected()),
            dispose: (_, value) => value.dispose(),
          ),
        ],
        child: LogoutListener(
          onLogout: (_) => sl<OSKPRepository>().clear(),
          child: child,
        ),
      );
}
