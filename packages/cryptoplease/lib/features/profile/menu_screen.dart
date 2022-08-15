import 'package:cryptoplease/app/components/refresh_balance_wrapper.dart';
import 'package:cryptoplease/features/profile/components/menu_header.dart';
import 'package:cryptoplease/features/profile/components/menu_section.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => RefreshBalancesWrapper(
        builder: (context, _) => CpTheme.light(
          child: ColoredBox(
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: ColoredBox(
                color: CpColors.lightGreyBackground,
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: const [
                    MenuHeader(),
                    MenuSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
