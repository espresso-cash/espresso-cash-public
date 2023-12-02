import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../ui/app_bar.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';

enum QuizPageType { question, result }

class QuizPage extends StatelessWidget {
  const QuizPage({
    super.key,
    required this.title,
    required this.content,
    required this.footer,
    required this.type,
  });

  final String title;
  final Widget content;
  final QuizPageType type;
  final List<CpButton> footer;

  Color get backgroundColor => switch (type) {
        QuizPageType.question => const Color(0xFFB7A572),
        QuizPageType.result => CpColors.darkSplashBackgroundColor
      };

  @override
  Widget build(BuildContext context) => CpTheme(
        theme: const CpThemeData.black(),
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: CpAppBar(
            title: Text(title),
            leading: CpBackButton(
              onPressed: () => context.router.pop(),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: content,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...footer,
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
