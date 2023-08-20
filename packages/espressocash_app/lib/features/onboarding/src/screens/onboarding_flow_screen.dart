import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/router_wrapper.dart';
import '../../../../di.dart';
import '../../../../routes.gr.dart';
import '../../../accounts/models/ec_wallet.dart';
import '../../../accounts/services/accounts_bloc.dart';
import '../../../profile/screens/manage_profile_screen.dart';
import '../data/onboarding_repository.dart';
import 'no_email_and_password_screen.dart';
import 'view_recovery_phrase_screen.dart';

@RoutePage()
class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({super.key});

  static const route = OnboardingFlowRoute.new;

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen>
    with RouterWrapper {
  void _handleNoEmailAndPasswordCompleted() =>
      router?.push(ViewRecoveryPhraseScreen.route(onDone: _openProfileScreen));

  void _handleComplete() {
    sl<OnboardingRepository>().hasFinishedOnboarding = true;
    router?.parent()?.pop();
  }

  void _openProfileScreen() =>
      router?.push(ManageProfileScreen.route(onSubmitted: _handleComplete));

  @override
  PageRouteInfo get initialRoute {
    final account = context.read<AccountsBloc>().state.account;

    return account?.wallet is SagaWallet
        ? ManageProfileScreen.route(onSubmitted: _handleComplete)
            as PageRouteInfo
        : NoEmailAndPasswordScreen.route(
            onDone: _handleNoEmailAndPasswordCompleted,
          );
  }

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}
