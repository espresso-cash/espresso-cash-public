import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/accounts/bl/accounts_bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../../routes.gr.dart';

class OnboardingNotice extends StatelessWidget {
  const OnboardingNotice({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) => state.hasFinishedOnboarding
            ? const SizedBox.shrink()
            : Container(
                height: 125,
                margin: const EdgeInsets.only(bottom: 24),
                child: GestureDetector(
                  onTap: () =>
                      context.router.navigate(const OnboardingFlowRoute()),
                  child: Assets.rive.onboardingNotice.rive(
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
      );
}
