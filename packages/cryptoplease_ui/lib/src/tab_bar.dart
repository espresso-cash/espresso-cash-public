import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class CpTabBar extends StatelessWidget {
  const CpTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(
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
          tabs: tabs,
        ),
      );
}

const double _barPadding = 16;
