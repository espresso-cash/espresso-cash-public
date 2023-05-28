import 'package:flutter/material.dart';

import '../app_bar.dart';
import '../background_gradient.dart';
import '../theme.dart';
import 'decorated_window_header.dart';

enum BackgroundStyle { gradient, light, dark }

class DecoratedWindow extends StatelessWidget {
  const DecoratedWindow({
    super.key,
    this.title,
    this.message,
    required this.child,
    this.nextButton,
    this.backButton,
    this.hasLogo = false,
    this.isScrollable = true,
    this.backgroundStyle = BackgroundStyle.gradient,
    this.markdownMessage = false,
    this.bottomButton,
  });

  final Widget child;
  final String? title;
  final String? message;
  final Widget? nextButton;
  final Widget? backButton;
  final bool hasLogo;
  final bool isScrollable;
  final BackgroundStyle backgroundStyle;
  final bool markdownMessage;
  final Widget? bottomButton;

  @override
  Widget build(BuildContext context) {
    final layout = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: DecoratedWindowHeader(
            hasLogo: hasLogo,
            title: title,
            message: message,
            markdownMessage: markdownMessage,
          ),
        ),
        Expanded(child: child),
        if (bottomButton != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: bottomButton,
          ),
      ],
    );
    final content = CpTheme(
      theme: backgroundStyle == BackgroundStyle.light
          ? const CpThemeData.light()
          : const CpThemeData.dark(),
      child: Scaffold(
        appBar: CpAppBar(
          leading: backButton,
          nextButton: nextButton,
        ),
        backgroundColor: backgroundStyle == BackgroundStyle.gradient
            ? Colors.transparent
            : null,
        body: isScrollable
            ? LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  physics: const RangeMaintainingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(child: layout),
                  ),
                ),
              )
            : layout,
      ),
    );
    switch (backgroundStyle) {
      case BackgroundStyle.dark:
      case BackgroundStyle.light:
        return content;
      case BackgroundStyle.gradient:
        return CpBackgroundGradient(child: content);
    }
  }
}
