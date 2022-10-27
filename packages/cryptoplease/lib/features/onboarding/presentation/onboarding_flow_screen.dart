import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/data/files.dart';
import 'package:cryptoplease/features/onboarding/bl/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen>
    implements OnboardingRouter {
  @override
  void onSignIn() {
    context.router.push(const RestoreAccountRoute());
  }

  @override
  void onSignUp() {
    context.router.push(const NoEmailAndPasswordRoute());
  }

  @override
  void onExplainNoEmailAndPasswordCompleted() {
    context.router.push(const CreateRecoveryPhraseRoute());
  }

  @override
  void onMnemonicConfirmed() => context.router.push(const CreateProfileRoute());

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider(
            create: (_) => OnboardingBloc(
              copyToAppDir,
              context.read<AccountsBloc>(),
            ),
          ),
          Provider<OnboardingRouter>.value(value: this),
        ],
        child: const AutoRouter(),
      );
}

abstract class OnboardingRouter {
  void onSignUp();
  void onSignIn();
  void onExplainNoEmailAndPasswordCompleted();
  void onMnemonicConfirmed();
}

extension OnboardingRouterExt on BuildContext {
  OnboardingRouter get onboardingRouter => read<OnboardingRouter>();
}
