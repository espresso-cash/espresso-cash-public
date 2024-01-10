import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../../../../routes.gr.dart';
import '../../../../core/router_wrapper.dart';
import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../data/quiz_repository.dart';
import '../models/quiz.dart';
import 'quiz_answer_screen.dart';
import 'quiz_intro_screen.dart';
import 'quiz_question_screen.dart';
import 'recovery_phrase_screen.dart';

@RoutePage<bool>()
class ViewPhraseFlowScreen extends StatefulWidget {
  const ViewPhraseFlowScreen({super.key});

  static const route = ViewPhraseFlowRoute.new;

  @override
  State<ViewPhraseFlowScreen> createState() => _ViewPhraseFlowScreenState();
}

class _ViewPhraseFlowScreenState extends State<ViewPhraseFlowScreen>
    with RouterWrapper, SingleTickerProviderStateMixin {
  late IList<QuizQuestion> _questions;
  final HeroController _heroController = HeroController();
  int _current = 0;

  late final _indicatorController = AnimationController(
    vsync: this,
    value: 0,
    lowerBound: 0,
    upperBound: (_indicatorCount - 1).toDouble(),
    duration: const Duration(milliseconds: 400),
  );

  String _questionTitle(int index) =>
      '${index % 2 + 1} OF ${_questions.length}';

  int get _indicatorCount => _questions.length + 1;

  void _pushQuestion(int index) {
    _current = index;
    _indicatorController.animateTo(index.toDouble());
    router?.replace(
      QuizQuestionScreen.route(
        key: ValueKey('question_$index'),
        indicator: _indicatorController,
        onButtonPressed: (isCorrect) =>
            isCorrect ? _handleCorrectAnswer(index) : _handleWrongAnswer(index),
        question: _questions[index],
        title: _questionTitle(index),
      ),
    );
  }

  void _handleQuestionPopped() {
    _current--;
    _indicatorController.animateTo(_current.toDouble());
  }

  void _handleCorrectAnswer(int index) {
    router?.push(
      QuizAnswerScreen.route(
        key: ValueKey('answer_$index'),
        indicator: _indicatorController,
        isCorrect: true,
        onButtonPressed: () => _handleNextQuestion(index),
        explanation: _questions[index].correctExplanation,
        title: _questionTitle(index),
      ),
    );
  }

  void _handleWrongAnswer(int index) {
    router?.push(
      QuizAnswerScreen.route(
        key: ValueKey('answer_$index'),
        indicator: _indicatorController,
        isCorrect: false,
        onButtonPressed: () => router?.pop(),
        explanation: _questions[index].incorrectExplanation,
        title: _questionTitle(index),
      ),
    );
  }

  void _handleNextQuestion(int index) {
    if (index + 1 < _questions.length) {
      _pushQuestion(index + 1);
    } else {
      _handleCompleteQuiz();
    }
  }

  void _handleCompleteQuiz() {
    _indicatorController.animateTo(_indicatorCount - 1);
    router?.replaceAll([
      QuizRecoveryScreen.route(
        onComplete: _handleCompleted,
        indicator: _indicatorController,
      ),
    ]);
  }

  void _handleCompleted() => context.router.pop();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _questions = sl<QuizRepository>().getQuestions(context.l10n);
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    _heroController.dispose();
    super.dispose();
  }

  @override
  PageRouteInfo get initialRoute =>
      QuizIntroScreen.route(onConfirmed: () => _pushQuestion(0));

  @override
  Widget build(BuildContext context) => HeroControllerScope(
        controller: _heroController,
        child: AutoRouter(
          key: routerKey,
          navigatorObservers: () => [
            _Observer(onQuestionPopped: _handleQuestionPopped),
          ],
        ),
      );
}

class _Observer extends NavigatorObserver {
  _Observer({required this.onQuestionPopped});

  final VoidCallback onQuestionPopped;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final args = route.settings.arguments;
    if (args is! QuizQuestionRouteArgs) return;

    onQuestionPopped();
  }
}
