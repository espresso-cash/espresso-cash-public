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

  @override
  Widget build(BuildContext context) => Container(
        height: 50,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: _backgroundColor(variant),
          shape: const StadiumBorder(),
        ),
        child: TabBar(
          indicatorColor: Colors.transparent,
          unselectedLabelColor: _unselectedLabelColor(variant),
          labelColor: _labelColor(variant),
          labelStyle: Theme.of(context).textTheme.headline3?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
          indicator: ShapeDecoration(
            color: _indicatorBackground(variant),
            shape: const StadiumBorder(),
          ),
          padding: const EdgeInsets.all(6),
          tabs: tabs,
        ),
      );
}

Color _backgroundColor(CpTabBarVariant variant) {
  switch (variant) {
    case CpTabBarVariant.dark:
      return CpColors.darkBackground;
    case CpTabBarVariant.inverted:
      return CpColors.yellowColor;
  }
}

Color _indicatorBackground(CpTabBarVariant variant) {
  switch (variant) {
    case CpTabBarVariant.dark:
      return Colors.white;
    case CpTabBarVariant.inverted:
      return Colors.black;
  }
}

Color _labelColor(CpTabBarVariant variant) {
  switch (variant) {
    case CpTabBarVariant.dark:
      return Colors.black;
    case CpTabBarVariant.inverted:
      return Colors.white;
  }
}

Color _unselectedLabelColor(CpTabBarVariant variant) {
  switch (variant) {
    case CpTabBarVariant.dark:
      return CpColors.disabledTabColor;
    case CpTabBarVariant.inverted:
      return Colors.black;
  }
}
