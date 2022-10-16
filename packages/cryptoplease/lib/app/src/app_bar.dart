import 'package:cryptoplease/app/ui/colors.dart';
import 'package:flutter/material.dart';

class CpAppBar extends AppBar {
  CpAppBar({
    Key? key,
    Widget? title,
    Widget? leading,
    Widget? nextButton,
    bool automaticallyImplyLeading = true,
  }) : super(
          key: key,
          leading: leading,
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
          titleTextStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: CpColors.menuPrimaryTextColor,
            letterSpacing: .23,
          ),
        );
}
