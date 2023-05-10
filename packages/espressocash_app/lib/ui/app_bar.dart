import 'package:flutter/material.dart';

import 'back_button.dart';

class CpAppBar extends AppBar {
  CpAppBar({
    Key? key,
    Widget? title,
    Widget? leading,
    Widget? nextButton,
    bool automaticallyImplyLeading = true,
  }) : super(
          key: key,
          leading: leading ?? const CpBackButton(ensureBackNavigation: true),
          automaticallyImplyLeading: automaticallyImplyLeading,
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
          title: title,
          elevation: 0,
          shape: const Border(),
        );
}
