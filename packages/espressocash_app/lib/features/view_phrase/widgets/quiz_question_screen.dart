import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/button.dart';
import '../../../utils/callback.dart';
import '../models/quiz.dart';
import 'quiz_page.dart';

class QuizQuestionView extends StatelessWidget {
  const QuizQuestionView({
    super.key,
    required this.question,
    required this.title,
    required this.onButtonPressed,
    required this.indicator,
  });

  final Widget indicator;
  final QuizQuestion question;
  final String title;
  final Callback1<bool> onButtonPressed;

  @override
  Widget build(BuildContext context) => QuizPage(
        title: title,
        indicator: indicator,
        type: QuizPageType.light,
        content: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Assets.images.quizQuestionBg.image(
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Container(
              decoration: const BoxDecoration(color: Color(0xB7B7A572)),
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
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  question.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.23,
                  ),
                ),
              ),
            ),
          ],
        ),
        footer: question.options
            .mapIndexed(
              (i, entry) => CpButton(
                text: entry,
                onPressed: () => onButtonPressed(i == question.correctAnswer),
                size: CpButtonSize.big,
                width: 350,
              ),
            )
            .toList(),
      );
}
