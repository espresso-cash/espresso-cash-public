import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../routes.gr.dart';
import '../../../../core/router_wrapper.dart';
import '../../../../gen/assets.gen.dart';
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
    with RouterWrapper {
  void _handleStartQuiz() => router
      ?.replace(QuizQuestionScreen.route(onComplete: _handleCompleteQuiz));

  void _handleCompleteQuiz() {
    router?.replace(
      QuizRecoveryScreen.route(
        onComplete: _handleCompleted,
        showIndicator: true,
      ),
    );
  }

  void _handleCompleted() => context.router.pop();

  @override
  void didChangeDependencies() {
    precacheImage(Assets.images.quizIntroBg.provider(), context);
    precacheImage(Assets.images.quizQuestionBg.provider(), context);

    super.didChangeDependencies();
  }

  @override
  PageRouteInfo get initialRoute => QuizIntroScreen.route(
        onConfirmed: _handleStartQuiz,
      );

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}
