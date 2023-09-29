import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../accounts/models/account.dart';
import '../../../accounts/models/ec_wallet.dart';
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
    if (account?.accessMode == const AccessMode.seedInputted() ||
        account?.wallet is SagaWallet) {
      sl<OnboardingRepository>().hasConfirmedPassphrase = true;
    }
  }

  void _onPressed() => context.router.navigate(OnboardingFlowScreen.route());

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: sl<OnboardingRepository>(),
        builder: (context, child) =>
            sl<OnboardingRepository>().hasFinishedOnboarding
                ? const SizedBox.shrink()
                : AspectRatio(
                    aspectRatio: 450 / 100,
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
                              alignment: Alignment.center,
                              child: _Content(onPressed: _onPressed),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      );
}

class _Content extends StatelessWidget {
  const _Content({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: FittedBox(
              child: Text(
                context.l10n.onboardingNoticeMessage,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CpButton(
            text: context.l10n.onboardingNoticeFinishSetup,
            size: CpButtonSize.micro,
            onPressed: onPressed,
          ),
          const SizedBox(width: 24)
        ],
      );
}
