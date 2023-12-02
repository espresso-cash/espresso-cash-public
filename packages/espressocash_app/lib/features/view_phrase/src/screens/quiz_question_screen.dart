import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/button.dart';
import '../models/quiz.dart';
import '../widgets/quiz_page.dart';

@RoutePage()
class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({super.key, required this.onComplete});

  static const route = QuizQuestionRoute.new;

  final VoidCallback onComplete;

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  // @override
  // Widget build(BuildContext context) => QuizPage(
  //       title: '1 OF 2',
  //       type: QuizPageType.question,
  //       content: const _QuestionContent(
  //         question: 'If you lose your Secret Recovery Phrase, Espresso Cash...',
  //       ),
  //       footer: [
  //         CpButton(
  //           text: 'Can retrieve it for you',
  //           onPressed: () {},
  //           size: CpButtonSize.big,
  //           width: 350,
  //         ),
  //         CpButton(
  //           text: 'Can not help you',
  //           onPressed: () {},
  //           size: CpButtonSize.big,
  //           width: 350,
  //         ),
  //       ],
  //     );

  @override
  Widget build(BuildContext context) => QuizPage(
        title: '1 OF 2',
        type: QuizPageType.result,
        content: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: _ResultContent(
            isCorrect: false,
          ),
        ),
        footer: [
          CpButton(
            text: 'Continue',
            onPressed: () {},
            size: CpButtonSize.big,
            width: 350,
          ),
        ],
      );
}

class _ResultContent extends StatelessWidget {
  const _ResultContent({required this.isCorrect});

  final bool isCorrect;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 16),
          if (isCorrect)
            Assets.icons.successCheck2.svg(
              height: 95,
              width: 95,
            )
          else
            Assets.icons.failIcon.svg(
              height: 95,
              width: 95,
            ),
          const SizedBox(height: 24),
          Text(
            isCorrect ? 'Correct!' : 'Wrong!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  isCorrect ? const Color(0xFFFBC728) : const Color(0xFFF04E4E),
              fontSize: 40,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.23,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No one can help retrieve your Secret Recovery Phrase.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.23,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Record it, engrave it on metal, or stash it in various secret places to prevent loss. Once lost, it's gone forever.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.23,
            ),
          ),
        ],
      );
}

class _QuestionContent extends StatelessWidget {
  const _QuestionContent({
    required this.question,
  });
  final String question;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Assets.images.quizQuestionBg.image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
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
                question,
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
      );
}

class _QuestionScreen extends StatelessWidget {
  const _QuestionScreen({required this.question});

  final QuizQuestion question;

  @override
  Widget build(BuildContext context) => Container();
}

class _ResultScreen extends StatelessWidget {
  const _ResultScreen({
    required this.isCorrect,
    required this.explanation,
    required this.onButtonPressed,
  });

  final bool isCorrect;
  final Explanation explanation;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) => QuizPage(
        title: '1 OF 2',
        content: Column(
          children: [
            const SizedBox(height: 16),
            if (isCorrect)
              Assets.icons.successCheck2.svg(
                height: 95,
                width: 95,
              )
            else
              Assets.icons.failIcon.svg(
                height: 95,
                width: 95,
              ),
            const SizedBox(height: 24),
            Text(
              isCorrect ? 'Correct!' : 'Wrong!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isCorrect
                    ? const Color(0xFFFBC728)
                    : const Color(0xFFF04E4E),
                fontSize: 40,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.23,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              explanation.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.23,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              explanation.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
          ],
        ),
        footer: const [], //TODO
        type: QuizPageType.result,
      );
}
