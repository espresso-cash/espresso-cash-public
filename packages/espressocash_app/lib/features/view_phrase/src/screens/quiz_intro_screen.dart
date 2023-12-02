import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/button.dart';
import '../widgets/quiz_page.dart';

@RoutePage()
class QuizIntroScreen extends StatelessWidget {
  const QuizIntroScreen({super.key, required this.onConfirmed});

  static const route = QuizIntroRoute.new;

  final VoidCallback onConfirmed;

  @override
  Widget build(BuildContext context) => QuizPage(
        title: 'Security Quiz'.toUpperCase(),
        type: QuizPageType.question,
        content: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Assets.images.quizIntroBg.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'To access your Secret Recovery Phrase, You’ll need to correctly answer two questions.',
                textAlign: TextAlign.center,
                style: TextStyle(
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
            text: 'Get Started',
            onPressed: onConfirmed,
            size: CpButtonSize.big,
            width: 350,
          ),
        ],
      );
}
