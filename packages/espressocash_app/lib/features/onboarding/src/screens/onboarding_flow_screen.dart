import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/router_wrapper.dart';
import '../../../../di.dart';
import '../../../../routes.gr.dart';
import '../../../backup_phrase/backup_phrase.dart';
import '../../../profile/screens/manage_profile_screen.dart';
import '../data/onboarding_repository.dart';
import 'confirm_recovery_phrase_screen.dart';
import 'no_email_and_password_screen.dart';
import 'success_screen.dart';
import 'view_recovery_phrase_screen.dart';

@RoutePage<bool>()
class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  static const route = OnboardingFlowRoute.new;

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen>
    with RouterWrapper {
  void _handleProfileCompleted() => router?.push(
        NoEmailAndPasswordScreen.route(
          onDone: _handleNoEmailAndPasswordCompleted,
        ),
      );

  void _handleNoEmailAndPasswordCompleted() => router?.push(
        ViewRecoveryPhraseScreen.route(
          onConfirmed: _handleViewRecoveryPhraseCompleted,
        ),
      );

  void _handleViewRecoveryPhraseCompleted(String phrase) => router?.push(
        ConfirmRecoveryPhraseScreen.route(
          correctPhrase: phrase,
          onConfirmed: _openSuccessScreen,
        ),
      );

  void _openSuccessScreen() =>
      router?.push(OnboardingSuccessScreen.route(onDone: _handleComplete));

  void _handleComplete() {
    sl<OnboardingRepository>().hasConfirmedPassphrase = true;
    context.completePuzzleFlow();

    router?.parent()?.pop(true);
  }

  @override
  PageRouteInfo get initialRoute => sl<OnboardingRepository>().hasSetupProfile
      ? NoEmailAndPasswordScreen.route(
          onDone: _handleNoEmailAndPasswordCompleted,
        )
      : ManageProfileScreen.route(onSubmitted: _handleProfileCompleted)
          as PageRouteInfo;

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}
