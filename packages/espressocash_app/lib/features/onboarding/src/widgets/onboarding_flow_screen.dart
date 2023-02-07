import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../routes.gr.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/loader.dart';
import '../bl/onboarding_bloc.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen>
    implements OnboardingRouter {
  @override
  void onExplainNoEmailAndPasswordCompleted() {
    context.router.push(const ViewRecoveryPhraseRoute());
  }

  @override
  void onMnemonicConfirmed() =>
      context.router.push(const CreateProfileOnboardingScreen());

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<OnboardingRouter>.value(value: this),
        ],
        child: BlocConsumer<OnboardingBloc, OnboardingState>(
          listener: (context, state) => state.maybeWhen(
            failure: (e) => showErrorDialog(context, 'Error', e),
            success: (_) => context.router.pop(),
            orElse: ignore,
          ),
          builder: (context, state) => CpLoader(
            isLoading: state.isProcessing(),
            child: const AutoRouter(),
          ),
        ),
      );
}

abstract class OnboardingRouter {
  void onExplainNoEmailAndPasswordCompleted();
  void onMnemonicConfirmed();
}

extension OnboardingRouterExt on BuildContext {
  OnboardingRouter get onboardingRouter => read<OnboardingRouter>();
}
