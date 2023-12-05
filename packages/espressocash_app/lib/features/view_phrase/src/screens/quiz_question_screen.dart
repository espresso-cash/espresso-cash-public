import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
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
  late List<QuizQuestion> _questions;
  int _currentQuestionIndex = 0;

  String get _title => '${_currentQuestionIndex + 1} OF ${_questions.length}';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _questions = [
      QuizQuestion(
        question: context.l10n.quizFirstQuestion,
        options: {
          QuizOption.optionA: context.l10n.quizFirstQuestionOptionA,
          QuizOption.optionB: context.l10n.quizFirstQuestionOptionB,
        },
        correctAnswer: QuizOption.optionB,
        correctExplanation: (
          title: context.l10n.quizFirstQuestionExplanationTitle,
          description: context.l10n.quizFirstQuestionExplanationSubtitle1,
        ),
        incorrectExplanation: (
          title: context.l10n.quizFirstQuestionExplanationTitle,
          description: context.l10n.quizFirstQuestionExplanationSubtitle2,
        ),
      ),
      QuizQuestion(
        question: context.l10n.quizSecondQuestion,
        options: {
          QuizOption.optionA: context.l10n.quizSecondQuestionOptionA,
          QuizOption.optionB: context.l10n.quizSecondQuestionOptionB,
        },
        correctAnswer: QuizOption.optionA,
        correctExplanation: (
          title: context.l10n.quizSecondQuestionExplanationTitle,
          description: context.l10n.quizSecondQuestionExplanationSubtitle,
        ),
        incorrectExplanation: (
          title: context.l10n.quizSecondQuestionExplanationTitle,
          description: context.l10n.quizSecondQuestionExplanationSubtitle,
        ),
      ),
    ];
  }

  void _handleButtonPress() {
    if (_currentQuestionIndex == _questions.length - 1) {
      widget.onComplete();
    } else {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) => _QuestionScreen(
        title: _title,
        question: _questions[_currentQuestionIndex],
        onButtonPressed: _handleButtonPress,
        index: _currentQuestionIndex,
      );
}

class _QuestionScreen extends StatelessWidget {
  const _QuestionScreen({
    required this.question,
    required this.title,
    required this.onButtonPressed,
    required this.index,
  });

  final int index;
  final QuizQuestion question;
  final String title;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) => QuizPage(
        title: title,
        type: QuizPageType.light,
        indicatorIndex: index,
        content: Stack(
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
        footer: question.options.entries
            .map(
              (entry) => CpButton(
                text: entry.value,
                onPressed: () {
                  if (entry.key == question.correctAnswer) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => _ResultScreen(
                          title: title,
                          isCorrect: true,
                          index: index,
                          explanation: question.correctExplanation,
                          onButtonPressed: () {
                            Navigator.pop(context);
                            onButtonPressed();
                          },
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => _ResultScreen(
                          title: title,
                          isCorrect: false,
                          index: index,
                          explanation: question.incorrectExplanation,
                          onButtonPressed: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  }
                },
                size: CpButtonSize.big,
                width: 350,
              ),
            )
            .toList(),
      );
}

class _ResultScreen extends StatelessWidget {
  const _ResultScreen({
    required this.isCorrect,
    required this.explanation,
    required this.onButtonPressed,
    required this.title,
    required this.index,
  });

  final String title;
  final int index;
  final bool isCorrect;
  final Explanation explanation;
  final VoidCallback onButtonPressed;

  SvgGenImage get image =>
      isCorrect ? Assets.icons.successCheck2 : Assets.icons.failIcon;

  @override
  Widget build(BuildContext context) => QuizPage(
        title: title,
        indicatorIndex: index,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              image.svg(
                height: 95,
                width: 95,
              ),
              const SizedBox(height: 24),
              Text(
                isCorrect ? context.l10n.quizCorrect : context.l10n.quizWrong,
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
        ),
        footer: [
          CpButton(
            text: isCorrect
                ? context.l10n.quizContinue
                : context.l10n.quizTryAgain,
            onPressed: onButtonPressed,
            size: CpButtonSize.big,
            width: 350,
          ),
        ],
        type: QuizPageType.dark,
      );
}
