import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../data/quiz_repository.dart';
import '../models/quiz.dart';
import '../widgets/quiz_answer_view.dart';
import '../widgets/quiz_indicator.dart';
import '../widgets/quiz_question_screen.dart';
import '../widgets/recovery_phrase_view.dart';

part 'quiz_screen.freezed.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late IList<QuizQuestion> _questions;

  QuizState _state = const QuizState.question(index: 0);

  late final _indicatorController = AnimationController(
    vsync: this,
    value: 0,
    lowerBound: 0,
    upperBound: _questions.length.toDouble(),
    duration: const Duration(milliseconds: 400),
  );

  final _indicatorKey = GlobalKey();

  late final _indicator = QuizIndicator(
    key: _indicatorKey,
    controller: _indicatorController,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _questions = sl<QuizRepository>().getQuestions(context.l10n);
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    super.dispose();
  }

  String _questionTitle(int index) =>
      '${index % 2 + 1} OF ${_questions.length}';

  void _handleNextQuestion(int index) {
    if (index + 1 < _questions.length) {
      setState(() {
        _state = QuizState.question(index: index + 1);
        _indicatorController.animateTo(index + 1);
      });
    } else {
      _handleQuizComplete();
    }
  }

  void _tryAgain(int index) => setState(() {
        _state = QuizState.question(index: index);
      });

  void _handleCorrectAnswer(int index) => setState(() {
        _state = QuizState.answer(index: index, isCorrect: true);
      });

  void _handleWrongAnswer(int index) => setState(() {
        _state = QuizState.answer(index: index, isCorrect: false);
      });

  void _handleQuizComplete() => setState(() {
        _state = const QuizState.success();
        _indicatorController.animateTo(_questions.length.toDouble());
      });

  @override
  Widget build(BuildContext context) => switch (_state) {
        QuizStateQuestion(:final index) => QuizQuestionView(
            question: _questions[index],
            title: _questionTitle(index),
            onButtonPressed: (isCorrect) => isCorrect
                ? _handleCorrectAnswer(index)
                : _handleWrongAnswer(index),
            indicator: _indicator,
          ),
        QuizStateAnswer(:final index, :final isCorrect) => QuizAnswerView(
            isCorrect: isCorrect,
            explanation: isCorrect
                ? _questions[index].correctExplanation
                : _questions[index].incorrectExplanation,
            onButtonPressed: () =>
                isCorrect ? _handleNextQuestion(index) : _tryAgain(index),
            title: _questionTitle(index),
            indicator: _indicator,
          ),
        QuizStateSuccess() => RecoveryPhraseView(indicator: _indicator),
      };
}

@freezed
sealed class QuizState with _$QuizState {
  const factory QuizState.question({required int index}) = QuizStateQuestion;

  const factory QuizState.answer({
    required int index,
    required bool isCorrect,
  }) = QuizStateAnswer;

  const factory QuizState.success() = QuizStateSuccess;
}
