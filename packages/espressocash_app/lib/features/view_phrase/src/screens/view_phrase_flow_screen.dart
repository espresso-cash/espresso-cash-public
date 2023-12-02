import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../routes.gr.dart';
import '../../../../core/router_wrapper.dart';
import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../onboarding/onboarding.dart';
import '../data/quiz_repository.dart';
import 'quiz_intro_screen.dart';
import 'quiz_question_screen.dart';
import 'view_warning_screen.dart';

@RoutePage<bool>()
class ViewPhraseFlowScreen extends StatefulWidget {
  const ViewPhraseFlowScreen({super.key});

  static const route = ViewPhraseFlowRoute.new;

  @override
  State<ViewPhraseFlowScreen> createState() => _ViewPhraseFlowScreenState();
}

class _ViewPhraseFlowScreenState extends State<ViewPhraseFlowScreen>
    with RouterWrapper {
  void _handleWarningConfirmed() => router?.replace(
        ViewRecoveryPhraseScreen.route(
          onConfirmed: (_) => _handleCompleted(),
          buttonLabel: context.l10n.ok,
        ),
      );

  void _handleStartQuiz() => router?.push(
        QuizQuestionScreen.route(
          onComplete: _handleCompleteQuiz,
        ),
      );

  void _handleCompleteQuiz() {
    // sl<QuizRepository>().hasCompletedQuiz = true;

    // router?.parent()?.pop(true); //TODO push view recovery phrase screen
  }

  void _handleCompleted() => context.router.pop();

  @override
  PageRouteInfo get initialRoute => sl<QuizRepository>().hasCompletedQuiz
      ? ViewPhraseWarningScreen.route(
          onConfirmed: _handleWarningConfirmed,
        )
      : QuizIntroScreen.route(
          onConfirmed: _handleStartQuiz,
        ) as PageRouteInfo;

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}
