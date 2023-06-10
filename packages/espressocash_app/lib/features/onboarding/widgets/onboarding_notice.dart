import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/accounts/bl/accounts_bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';

class OnboardingNotice extends StatelessWidget {
  const OnboardingNotice({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          if (state.hasFinishedOnboarding) return const SizedBox.shrink();

          void onPressed() =>
              context.router.navigate(const OnboardingFlowRoute());

          return AspectRatio(
            aspectRatio: 433 / 123,
            child: GestureDetector(
              onTap: onPressed,
              child: RepaintBoundary(
                child: Stack(
                  children: [
                    Assets.rive.onboardingNotice.rive(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _Content(
                        onPressed: onPressed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

class _Content extends StatelessWidget {
  const _Content({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: FractionallySizedBox(
          widthFactor: 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                child: _Text(),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: CpButton(
                  text: context.l10n.onboardingNoticeFinishSetup,
                  size: CpButtonSize.micro,
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      );
}

class _Text extends StatelessWidget {
  const _Text();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: FittedBox(
              child: Text(
                context.l10n.onboardingNoticeTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          FittedBox(
            child: Text(
              context.l10n.onboardingNoticeMessage,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
}
