import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/shake.dart';
import '../models/quiz.dart';
import 'quiz_page.dart';

class QuizAnswerView extends StatefulWidget {
  const QuizAnswerView({
    super.key,
    required this.isCorrect,
    required this.explanation,
    required this.onButtonPressed,
    required this.title,
    required this.indicator,
  });

  final String title;
  final Widget indicator;
  final bool isCorrect;
  final Explanation explanation;
  final VoidCallback onButtonPressed;

  @override
  State<QuizAnswerView> createState() => _QuizAnswerViewState();
}

class _QuizAnswerViewState extends State<QuizAnswerView> {
  final _shakeKey = GlobalKey<ShakeState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;

      if (!widget.isCorrect) {
        _shakeKey.currentState?.shake();
      }
    });
  }

  SvgGenImage get _image =>
      widget.isCorrect ? Assets.icons.successCheck2 : Assets.icons.failIcon;

  @override
  Widget build(BuildContext context) => QuizPage(
        title: widget.title,
        indicator: widget.indicator,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Shake(
                key: _shakeKey,
                child: _image.svg(
                  height: 95,
                  width: 95,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.isCorrect
                    ? context.l10n.quizCorrect
                    : context.l10n.quizWrong,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.isCorrect
                      ? const Color(0xFFFBC728)
                      : const Color(0xFFF04E4E),
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.23,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.explanation.title,
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
                widget.explanation.description,
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
        ),
        footer: [
          CpButton(
            text: widget.isCorrect
                ? context.l10n.quizContinue
                : context.l10n.quizTryAgain,
            onPressed: widget.onButtonPressed,
            size: CpButtonSize.big,
            width: 350,
          ),
        ],
        type: QuizPageType.dark,
      );
}
