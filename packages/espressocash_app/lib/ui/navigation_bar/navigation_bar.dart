import 'package:flutter/material.dart';

import '../colors.dart';
import 'navigation_button.dart';

class CPNavigationBar extends StatelessWidget {
  const CPNavigationBar({
    super.key,
    required this.items,
  });

  final List<CpNavigationButton> items;

  @override
  Widget build(BuildContext context) => Container(
        // prevents from clicking below the navigation bar
        padding: const EdgeInsets.only(bottom: 8),
        color: Colors.transparent,
        child: SafeArea(
          minimum: const EdgeInsets.only(
            bottom: _barPadding,
            left: _barPadding,
            right: _barPadding,
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const ShapeDecoration(
              color: CpColors.darkBackground,
              shape: StadiumBorder(),
            ),
            child: SizedBox(
              height: _barHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: items.map((child) => Expanded(child: child)).toList(),
              ),
            ),
          ),
        ),
      );
}

const cpNavigationBarheight = _barHeight + _barPadding;

const double _barHeight = 58;
const double _barPadding = 16;
