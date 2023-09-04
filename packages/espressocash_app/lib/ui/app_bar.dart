import 'package:flutter/material.dart';

import 'back_button.dart';

class CpAppBar extends AppBar {
  CpAppBar({
    super.key,
    super.title,
    Widget? leading,
    Widget? nextButton,
    Color backgroundColor = Colors.transparent,
    super.automaticallyImplyLeading,
  }) : super(
          backgroundColor: backgroundColor,
          clipBehavior: Clip.none,
          leading: leading ?? const CpBackButton(ensureBackNavigation: true),
          actions: nextButton != null
              ? [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 93),
                        child: nextButton,
                      ),
                    ),
                  ),
                ]
              : null,
          elevation: 0,
          shape: const Border(),
        );
}
