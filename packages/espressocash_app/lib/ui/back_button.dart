import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import 'icon_button.dart';

class CpBackButton extends StatelessWidget {
  const CpBackButton({
    Key? key,
    this.onPressed,
    this.ensureBackNavigation = false,
  }) : super(key: key);

  final bool ensureBackNavigation;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (ensureBackNavigation && !Navigator.of(context).canPop()) {
      return const SizedBox.shrink();
    }

    return CpIconButton(
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
