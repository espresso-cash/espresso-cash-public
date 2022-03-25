import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/round_corners_container.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class WalletTabBar extends StatelessWidget implements PreferredSizeWidget {
  const WalletTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        child: RoundCornersContainer(
          child: Container(
            height: preferredSize.height,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: CpColors.listDividerColor,
                  width: 1.0,
                ),
              ),
            ),
            child: TabBar(
              padding: const EdgeInsets.only(top: 5),
              indicatorColor: Colors.transparent,
              unselectedLabelColor: CpColors.disabledTabColor,
              labelColor: Colors.black,
              labelStyle: Theme.of(context).textTheme.headline3?.copyWith(
                    fontSize: 21,
                  ),
              tabs: [
                Tab(text: context.l10n.crypto),
                Tab(text: context.l10n.stablecoin)
              ],
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(82);
}
