import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/elements/badge.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    Key? key,
    required this.icon,
    required this.active,
    required this.onPressed,
    this.badge,
  }) : super(key: key);

  final SvgGenImage icon;
  final bool active;
  final VoidCallback onPressed;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    final badge = this.badge;

    return LayoutBuilder(
      builder: (context, constraints) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              icon.svg(
                height: 24,
                color: active ? CpColors.yellowColor : Colors.white,
              ),
              if (badge != null && badge > 0)
                Positioned(
                  top: 15,
                  left: constraints.maxWidth / 2 + 30 / 2,
                  child: Badge(value: badge),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
