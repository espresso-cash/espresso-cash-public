import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';

enum QuizPageType { light, dark }

typedef Indicator = AnimationController;

class QuizPage extends StatelessWidget {
  const QuizPage({
    super.key,
    this.title,
    required this.content,
    required this.footer,
    required this.type,
    this.indicator,
    this.backButton,
  });

  final String? title;
  final Widget content;
  final QuizPageType type;
  final List<CpButton> footer;
  final Widget? indicator;
  final Widget? backButton;

  Color get backgroundColor => switch (type) {
        QuizPageType.light => const Color(0xFFB7A572),
        QuizPageType.dark => CpColors.darkSplashBackgroundColor
      };

  @override
  Widget build(BuildContext context) => CpTheme(
        theme: const CpThemeData.black(),
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: CpAppBar(
            title: title?.let(Text.new),
            leading: backButton ?? const SizedBox.shrink(),
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraint) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 0.73,
                          child: Column(
                            children: [
                              Expanded(child: content),
                              if (indicator case final indicator?) indicator,
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ...footer.map(
                                (button) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: button,
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
