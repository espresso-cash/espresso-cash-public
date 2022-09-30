import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class WalletTabBar extends StatelessWidget implements PreferredSizeWidget {
  const WalletTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        child: Container(
          margin: const EdgeInsets.only(
            bottom: _barPadding,
            left: _barPadding,
            right: _barPadding,
          ),
          height: 50,
          clipBehavior: Clip.antiAlias,
          decoration: const ShapeDecoration(
            color: CpColors.darkBackground,
            shape: StadiumBorder(),
          ),
          child: TabBar(
            indicatorColor: Colors.transparent,
            unselectedLabelColor: CpColors.disabledTabColor,
            labelColor: Colors.black,
            labelStyle: Theme.of(context).textTheme.headline3?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
            indicator: const ShapeDecoration(
              color: Colors.white,
              shape: StadiumBorder(),
            ),
            padding: const EdgeInsets.all(6),
            tabs: [
              Tab(text: context.l10n.stablecoin),
              Tab(text: context.l10n.crypto),
              const Tab(text: 'All')
            ],
          ),
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

const double _barPadding = 16;
