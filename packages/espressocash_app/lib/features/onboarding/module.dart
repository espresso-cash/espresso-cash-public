import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/accounts_bloc.dart';
import '../../core/accounts/bl/ec_wallet.dart';
import '../../di.dart';
import '../../routes.gr.dart';
import '../backup_phrase/mnemonic_getter.dart';
import 'src/bl/onboarding_bloc.dart';

class OnboardingModule extends SingleChildStatelessWidget {
  const OnboardingModule({
    Key? key,
    Widget? child,
    required this.mnemonic,
  }) : super(key: key, child: child);

  final Future<String> mnemonic;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider(create: (_) => sl<OnboardingBloc>()),
          Provider<MnemonicGetter>(create: (_) => MnemonicGetter(mnemonic)),
        ],
        child: BlocListener<OnboardingBloc, OnboardingState>(
          listener: (context, state) => state.maybeWhen(
            success: (result) => context.read<AccountsBloc>().add(
                  AccountsEvent.profileUpdated(
                    name: result.name,
                    photo: result.photo,
                  ),
                ),
            orElse: ignore,
          ),
          child: child,
        ),
      );
}

class RecoveryPhraseGuard extends AutoRouteGuard {
  RecoveryPhraseGuard(this._accountsBloc);

  final AccountsBloc _accountsBloc;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isSagaWallet = _accountsBloc.state.account?.wallet is SagaWallet;

    // Skips all the recovery phrase steps if is a Saga Wallet
    if (isSagaWallet) {
      router.push(const CreateProfileOnboardingScreen());
    } else {
      resolver.next(true);
    }
  }
}
