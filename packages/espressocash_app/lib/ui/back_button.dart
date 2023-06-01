import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import 'icon_button.dart';

class CpBackButton extends StatelessWidget {
  const CpBackButton({
    super.key,
    this.onPressed,
    this.ensureBackNavigation = false,
  });

  final bool ensureBackNavigation;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final canPop =
        Navigator.maybeOf(context) != null && Navigator.of(context).canPop();

    return ensureBackNavigation && !canPop
        ? const SizedBox.shrink()
        : CpIconButton(
            icon: Assets.icons.arrow.svg(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            variant: CpIconButtonVariant.transparent,
            onPressed: onPressed ?? () => Navigator.of(context).pop(),
          );
  }
}
