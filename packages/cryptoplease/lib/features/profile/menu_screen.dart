import 'package:cryptoplease/app/components/refresh_balance_wrapper.dart';
import 'package:cryptoplease/features/profile/components/menu_header.dart';
import 'package:cryptoplease/features/profile/components/menu_section.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => RefreshBalancesWrapper(
        builder: (context, onRefresh) => CpTheme.light(
          child: RefreshIndicator(
            displacement: 80,
            notificationPredicate: T,
            onRefresh: onRefresh,
            backgroundColor: Colors.white,
            color: CpColors.primaryColor,
            child: DecoratedBox(
              decoration: _menuScreenBackground,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
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
            ),
          ),
        ),
      );
}

const _menuScreenBackground = BoxDecoration(
  gradient: LinearGradient(
    stops: [0.5, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Colors.white,
      CpColors.lightGreyBackground,
    ],
  ),
);
