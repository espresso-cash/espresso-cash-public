import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../widgets/quiz_page.dart';
import 'quiz_screen.dart';

class QuizIntroScreen extends StatelessWidget {
  const QuizIntroScreen({
    super.key,
    required this.onConfirmed,
  });

  final VoidCallback onConfirmed;

  @override
  Widget build(BuildContext context) => QuizPage(
        title: context.l10n.quizIntroTitle.toUpperCase(),
        type: QuizPageType.light,
        backButton: const CpBackButton(),
        content: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Assets.images.quizIntroBg.image(
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Container(
              height: 120,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00B7A572), Color(0xFFB7A572)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                context.l10n.quizIntroDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.23,
                ),
              ),
            ),
          ],
        ),
        footer: [
          CpButton(
            text: context.l10n.quizStart,
            onPressed: onConfirmed,
            size: CpButtonSize.big,
            width: 350,
          ),
        ],
      );
}

class QuizIntroRoute extends GoRouteData {
  const QuizIntroRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => QuizIntroScreen(
        onConfirmed: () => const QuizRoute().go(context),
      );
}
