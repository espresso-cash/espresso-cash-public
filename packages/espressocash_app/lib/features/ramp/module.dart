import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../accounts/models/account.dart';
import '../accounts/module.dart';
import '../balances/widgets/context_ext.dart';
import 'src/data/repository.dart';
import 'src/services/coinflow_withdrawn_watcher.dart';
import 'src/services/tx_created_watcher.dart';
import 'src/services/tx_sent_watcher.dart';

class ORPModule extends SingleChildStatelessWidget {
  const ORPModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
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
          Provider<CoinflowWithdrawWatcher>(
            lazy: false,
            create: (context) => sl<CoinflowWithdrawWatcher>(
              param1: context.read<MyAccount>().wallet.publicKey,
            )..init(),
            dispose: (_, value) => value.dispose(),
          ),
        ],
        child: LogoutListener(
          onLogout: (_) => sl<ORPRepository>().clear(),
          child: child,
        ),
      );
}
