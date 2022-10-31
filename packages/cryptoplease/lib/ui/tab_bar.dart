import 'package:flutter/material.dart';

import 'colors.dart';

enum CpTabBarVariant { dark, inverted }

class CpTabBar extends StatelessWidget {
  const CpTabBar({
    super.key,
    this.variant = CpTabBarVariant.dark,
    required this.tabs,
  });

  final CpTabBarVariant variant;
  final List<Widget> tabs;

  Color get _backgroundColor {
    switch (variant) {
      case CpTabBarVariant.dark:
        return CpColors.darkBackground;
      case CpTabBarVariant.inverted:
        return CpColors.yellowColor;
    }
  }

  Color get _indicatorBackground {
    switch (variant) {
      case CpTabBarVariant.dark:
        return Colors.white;
      case CpTabBarVariant.inverted:
        return Colors.black;
    }
  }

  Color get _labelColor {
    switch (variant) {
      case CpTabBarVariant.dark:
        return Colors.black;
      case CpTabBarVariant.inverted:
        return Colors.white;
    }
  }

  Color get _unselectedLabelColor {
    switch (variant) {
      case CpTabBarVariant.dark:
        return CpColors.disabledTabColor;
      case CpTabBarVariant.inverted:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        height: 50,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: _backgroundColor,
          shape: const StadiumBorder(),
        ),
        child: TabBar(
          indicatorColor: Colors.transparent,
          unselectedLabelColor: _unselectedLabelColor,
          labelColor: _labelColor,
          labelStyle: Theme.of(context).textTheme.headline3?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
          indicator: ShapeDecoration(
            color: _indicatorBackground,
            shape: const StadiumBorder(),
          ),
          padding: const EdgeInsets.all(6),
          tabs: tabs,
        ),
      );
}
