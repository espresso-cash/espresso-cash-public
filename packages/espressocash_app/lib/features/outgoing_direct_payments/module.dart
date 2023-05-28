import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/module.dart';
import '../../core/balances/context_ext.dart';
import '../../di.dart';
import 'src/bl/repository.dart';
import 'src/bl/tx_created_watcher.dart';
import 'src/bl/tx_sent_watcher.dart';
import 'src/widgets/link_listener.dart';

class ODPModule extends SingleChildStatelessWidget {
  const ODPModule({super.key, super.child});

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
          onLogout: (_) => sl<ODPRepository>().clear(),
          child: ODPLinkListener(child: child ?? const SizedBox.shrink()),
        ),
      );
}
