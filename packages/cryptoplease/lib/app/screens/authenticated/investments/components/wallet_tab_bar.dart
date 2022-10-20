import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/tab_bar.dart';
import 'package:flutter/material.dart';

class WalletTabBar extends StatelessWidget {
  const WalletTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTabBar(
        tabs: [
          Tab(text: context.l10n.crypto),
          Tab(text: context.l10n.stablecoin),
          Tab(text: context.l10n.all)
        ],
      );
}
