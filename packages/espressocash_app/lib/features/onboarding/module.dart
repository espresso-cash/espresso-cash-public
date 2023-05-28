import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/accounts_bloc.dart';
import '../../di.dart';
import '../backup_phrase/mnemonic_getter.dart';
import 'src/bl/onboarding_bloc.dart';

class OnboardingModule extends SingleChildStatelessWidget {
  const OnboardingModule({
    super.key,
    super.child,
    required this.mnemonic,
  });

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
