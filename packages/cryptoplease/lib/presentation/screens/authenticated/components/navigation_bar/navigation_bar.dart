import 'package:cryptoplease/presentation/screens/authenticated/components/navigation_bar/navigation_button.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class CPNavigationBar extends StatelessWidget {
  const CPNavigationBar({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<NavigationButton> items;

  @override
  Widget build(BuildContext context) => Container(
        // prevents from clicking below the navigation bar
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(
            bottom: _barPadding,
            left: _barPadding,
            right: _barPadding,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: const ShapeDecoration(
            color: CpColors.primaryTextColor,
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
      );
}

const cpNavigationBarheight = _barHeight + _barPadding;

const double _barHeight = 60;
const double _barPadding = 16;
