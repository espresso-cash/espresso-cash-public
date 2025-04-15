import 'package:flutter/material.dart';

import 'colors.dart';

enum CpTabBarVariant { dark, inverted, light, black }

class CpTabBar extends StatelessWidget {
  const CpTabBar({
    super.key,
    this.variant = CpTabBarVariant.black,
    required this.tabs,
    this.controller,
  });

  final CpTabBarVariant variant;
  final List<Widget> tabs;
  final TabController? controller;

  @override
  Widget build(BuildContext context) => Container(
    height: 50,
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(color: _backgroundColor(variant), shape: const StadiumBorder()),
    child: TabBar(
      controller: controller,
      indicatorColor: Colors.transparent,
      unselectedLabelColor: _unselectedLabelColor(variant),
      labelColor: _labelColor(variant),
      labelStyle: Theme.of(
        context,
      ).textTheme.displaySmall?.copyWith(fontSize: 13, fontWeight: FontWeight.w500),
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
    case CpTabBarVariant.light:
      return CpColors.deepGreyColor;
    case CpTabBarVariant.inverted:
      return CpColors.yellowColor;
    case CpTabBarVariant.black:
      return CpColors.blackGreyColor;
  }
}

Color _indicatorBackground(CpTabBarVariant variant) {
  switch (variant) {
    case CpTabBarVariant.dark:
      return Colors.white;
    case CpTabBarVariant.inverted:
      return Colors.black;
    case CpTabBarVariant.black:
    case CpTabBarVariant.light:
      return CpColors.yellowColor;
  }
}

Color _labelColor(CpTabBarVariant variant) {
  switch (variant) {
    case CpTabBarVariant.black:
    case CpTabBarVariant.dark:
    case CpTabBarVariant.light:
      return CpColors.blackGreyColor;
    case CpTabBarVariant.inverted:
      return Colors.white;
  }
}

Color _unselectedLabelColor(CpTabBarVariant variant) {
  switch (variant) {
    case CpTabBarVariant.black:
    case CpTabBarVariant.dark:
    case CpTabBarVariant.light:
      return Colors.white;
    case CpTabBarVariant.inverted:
      return Colors.black;
  }
}
