import 'package:cryptoplease/presentation/components/decorated_window_header.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

enum BackgroundStyle { gradient, light, dark }

class DecoratedWindow extends StatelessWidget {
  const DecoratedWindow({
    Key? key,
    this.title,
    this.message,
    required this.child,
    this.nextButton,
    this.backButton,
    this.hasLogo = false,
    this.isScrollable = true,
    this.backgroundStyle = BackgroundStyle.gradient,
    this.markdownMessage = false,
    this.hasAppBarBorder = true,
    this.bottomButton,
  }) : super(key: key);

  final Widget child;
  final String? title;
  final String? message;
  final Widget? nextButton;
  final Widget? backButton;
  final bool hasLogo;
  final bool isScrollable;
  final BackgroundStyle backgroundStyle;
  final bool markdownMessage;
  final bool hasAppBarBorder;
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
          hasBorder: hasAppBarBorder,
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
        return content;
      case BackgroundStyle.gradient:
        return CpBackgroundGradient(child: content);
      case BackgroundStyle.light:
        return content;
    }
  }
}
