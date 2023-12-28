import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/callback.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/button.dart';
import '../../../../ui/shake.dart';
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
  final PageController _controller = PageController();
  late List<QuizQuestion> _questions;
  int _currentPageIndex = 0;
  bool _isCorrect = false;

  String get _title => '${_currentPageIndex ~/ 2 + 1} OF ${_questions.length}';

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

  void _moveToPage(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.linear,
    );
  }

  void _handleQuestionButtonPress(bool isCorrect) {
    setState(() {
      _isCorrect = isCorrect;
      _currentPageIndex++;
    });
    _moveToPage(_currentPageIndex);
  }

  void _handleAnswerButtonPress() {
    if (_isCorrect && _currentPageIndex >= (_questions.length * 2 - 1)) {
      widget.onComplete();
    } else {
      setState(() {
        _isCorrect ? _currentPageIndex++ : _currentPageIndex--;
      });

      _moveToPage(_currentPageIndex);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PageView.builder(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _questions.length * 2,
        itemBuilder: (context, index) {
          final questionIndex = index ~/ 2;
          final isQuestionScreen = index.isEven;
          final question = _questions[questionIndex];

          return isQuestionScreen
              ? _QuestionScreen(
                  title: _title,
                  question: question,
                  onButtonPressed: _handleQuestionButtonPress,
                  index: questionIndex,
                )
              : _ResultScreen(
                  title: _title,
                  isCorrect: _isCorrect,
                  index: questionIndex,
                  explanation: _isCorrect
                      ? question.correctExplanation
                      : question.incorrectExplanation,
                  onButtonPressed: _handleAnswerButtonPress,
                );
        },
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
  final Callback1<bool> onButtonPressed;

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
                onPressed: () =>
                    onButtonPressed(entry.key == question.correctAnswer),
                size: CpButtonSize.big,
                width: 350,
              ),
            )
            .toList(),
      );
}

class _ResultScreen extends StatefulWidget {
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
  @override
  State<_ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<_ResultScreen> {
  final _shakeKey = GlobalKey<ShakeState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(const Duration(milliseconds: 400), () {
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
        indicatorIndex: widget.index,
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
