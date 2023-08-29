import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions.dart';
import '../../../../core/presentation/value_stream_builder.dart';
import '../../../../di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../accounts/models/account.dart';
import '../../../accounts/services/accounts_bloc.dart';
import '../data/onboarding_repository.dart';
import '../screens/onboarding_flow_screen.dart';

class OnboardingNotice extends StatefulWidget {
  const OnboardingNotice({super.key});

  @override
  State<OnboardingNotice> createState() => _OnboardingNoticeState();
}

class _OnboardingNoticeState extends State<OnboardingNotice> {
  @override
  void initState() {
    super.initState();

    final account = context.read<AccountsBloc>().state.account;
    if (account?.accessMode == const AccessMode.seedInputted()) {
      sl<OnboardingRepository>().hasFinishedOnboarding = true;
    }
  }

  void _onPressed() => context.router.navigate(OnboardingFlowScreen.route());

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<bool>(
        create: () => sl<OnboardingRepository>()
            .hasFinishedOnboardingStream
            .withInitial(),
        builder: (context, hasFinishedOnboarding) {
          if (hasFinishedOnboarding) return const SizedBox.shrink();

          return AspectRatio(
            aspectRatio: 433 / 123,
            child: GestureDetector(
              onTap: _onPressed,
              child: RepaintBoundary(
                child: Stack(
                  children: [
                    Assets.rive.onboardingNotice.rive(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _Content(onPressed: _onPressed),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Flexible(
              child: FractionallySizedBox(
                widthFactor: 0.75,
                child: _Text(),
              ),
            ),
            const SizedBox(height: 8, width: double.infinity),
            Flexible(
              child: Align(
                alignment: Alignment.center,
                child: CpButton(
                  text: context.l10n.onboardingNoticeFinishSetup,
                  size: CpButtonSize.micro,
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
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
