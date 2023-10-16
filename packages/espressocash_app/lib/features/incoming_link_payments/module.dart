import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../accounts/module.dart';
import '../balances/widgets/context_ext.dart';
import 'data/ilp_repository.dart';
import 'services/tx_created_watcher.dart';
import 'services/tx_sent_watcher.dart';
import 'widgets/pending_ilp_listener.dart';

class ILPModule extends SingleChildStatelessWidget {
  const ILPModule({super.key, super.child});

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
        ],
        child: LogoutListener(
          onLogout: (_) => sl<ILPRepository>().clear(),
          child: PendingILPListener(child: child ?? const SizedBox.shrink()),
        ),
      );
}
