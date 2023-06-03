import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/accounts/bl/accounts_bloc.dart';
import '../../../../core/accounts/bl/ec_wallet.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/loader.dart';
import '../bl/onboarding_bloc.dart';

@RoutePage()
class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen>
    implements OnboardingRouter {
  final _routerKey = GlobalKey<AutoRouterState>();

  StackRouter? get _router => _routerKey.currentState?.controller;

  @override
  void onExplainNoEmailAndPasswordCompleted() {
    _router?.push(const ViewRecoveryPhraseRoute());
  }

  @override
  void onMnemonicConfirmed() => _router?.push(const CreateProfileRoute());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<AccountsBloc>().state.account?.wallet is SagaWallet) {
        _router?.push(const CreateProfileRoute());
      } else {
        _router?.push(const NoEmailAndPasswordRoute());
      }
    });
  }

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
            child: AutoRouter(key: _routerKey),
          ),
        ),
      );
}

abstract class OnboardingRouter {
  const OnboardingRouter();

  void onExplainNoEmailAndPasswordCompleted();
  void onMnemonicConfirmed();
}

extension OnboardingRouterExt on BuildContext {
  OnboardingRouter get onboardingRouter => read<OnboardingRouter>();
}
