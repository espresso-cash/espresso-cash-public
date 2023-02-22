import 'package:flutter/material.dart';

import '../colors.dart';
import 'navigation_button.dart';

class CPNavigationBar extends StatelessWidget {
  const CPNavigationBar({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<CpNavigationButton> items;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Container(
          // prevents from clicking below the navigation bar
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.only(
              left: _barPadding,
              right: _barPadding,
            ),
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
