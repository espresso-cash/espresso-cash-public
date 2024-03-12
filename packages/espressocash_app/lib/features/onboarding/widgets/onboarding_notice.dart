import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/button.dart';
import '../../accounts/models/account.dart';
import '../../accounts/services/account_service.dart';
import '../data/onboarding_repository.dart';
import '../screens/onboarding_screen.dart';
import '../screens/view_recovery_phrase_screen.dart';

class OnboardingNotice extends StatefulWidget {
  const OnboardingNotice({super.key, required this.finishPath});

  final String finishPath;

  @override
  State<OnboardingNotice> createState() => _OnboardingNoticeState();
}

class _OnboardingNoticeState extends State<OnboardingNotice> {
  @override
  void initState() {
    super.initState();

    final account = sl<AccountService>().value;
    if (account?.accessMode == const AccessMode.seedInputted()) {
      sl<OnboardingRepository>().hasConfirmedPassphrase = true;
    }
  }

  void _handlePressed() {
    // OnboardingRoute(finishPath: widget.finishPath).push<void>(context);
    OnboardingRecoveryPhraseRoute(finishPath: widget.finishPath)
        .push<void>(context);
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: sl<OnboardingRepository>(),
        builder: (context, child) =>
            sl<OnboardingRepository>().hasFinishedOnboarding
                ? const SizedBox.shrink()
                : AspectRatio(
                    aspectRatio: 450 / 100,
                    child: GestureDetector(
                      onTap: _handlePressed,
                      child: RepaintBoundary(
                        child: Stack(
                          children: [
                            Assets.rive.onboardingNotice.rive(
                              alignment: Alignment.topCenter,
                              fit: BoxFit.fitWidth,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: _Content(onPressed: _handlePressed),
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
          const SizedBox(width: 24),
        ],
      );
}
