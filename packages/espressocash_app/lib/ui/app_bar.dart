import 'package:flutter/material.dart';

class CpAppBar extends AppBar {
  CpAppBar({
    super.key,
    super.title,
    super.leading,
    Widget? nextButton,
    super.automaticallyImplyLeading,
  }) : super(
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
