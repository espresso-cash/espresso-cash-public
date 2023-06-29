import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../core/router_wrapper.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../accounts/services/accounts_bloc.dart';
import '../data/onboarding_repository.dart';

@RoutePage()
class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen>
    with RouterWrapper {
  void _handleNoEmailAndPasswordCompleted() =>
      router?.push(ViewRecoveryPhraseRoute(onDone: _openProfileScreen));

  void _handleComplete() {
    sl<OnboardingRepository>().hasFinishedOnboarding = true;
    router?.parent()?.pop();
  }

  void _openProfileScreen() =>
      router?.push(ManageProfileRoute(onSubmitted: _handleComplete));

  @override
  PageRouteInfo get initialRoute {
    final account = context.read<AccountsBloc>().state.account;

    return account?.wallet is SagaWallet
        ? ManageProfileRoute(onSubmitted: _handleComplete) as PageRouteInfo
        : NoEmailAndPasswordRoute(onDone: _handleNoEmailAndPasswordCompleted);
  }

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}
