import 'package:flutter/material.dart';

import '../../../../../../ui/app_bar.dart';
import '../../../../../../ui/decorated_window/decorated_window_header.dart';
import '../../../../../../ui/theme.dart';

class PuzzleScreen extends StatelessWidget {
  const PuzzleScreen({
    super.key,
    this.title,
    required this.child,
    this.backButton,
  });

  final Widget child;
  final String? title;
  final Widget? backButton;

  @override
  Widget build(BuildContext context) {
    final title = this.title;

    return CpTheme(
      theme: const CpThemeData.dark(),
      child: Scaffold(
        appBar: CpAppBar(
          leading: backButton,
          title: title != null
              ? Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : null,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 28),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: DecoratedWindowHeader(),
            ),
            Expanded(child: child)
          ],
        ),
      ),
    );
  }
}
