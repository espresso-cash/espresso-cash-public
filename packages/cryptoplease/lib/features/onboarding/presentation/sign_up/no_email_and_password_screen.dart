import 'package:cryptoplease/features/onboarding/presentation/sign_up/sign_up_flow_screen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/info_icon.dart';
import 'package:cryptoplease/ui/info_widget.dart';
import 'package:cryptoplease/ui/onboarding_screen.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoEmailAndPasswordScreen extends StatelessWidget {
  const NoEmailAndPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: OnboardingScreen(
            footer: FooterButton(
              text: context.l10n.iUnderstand,
              onPressed: () => context
                  .read<SignUpRouter>()
                  .onExplainNoEmailAndPasswordCompleted(),
            ),
            children: [
              CpAppBar(),
              const OnboardingLogo(),
              OnboardingPadding(
                child: CpInfoWidget(
                  icon: const CpInfoIcon(),
                  message: Text(
                    context.l10n.noEmailInCryptoInfo,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 38),
              OnboardingDescription(
                text: context.l10n.noEmailInCryptoParagraph,
              ),
            ],
          ),
        ),
      );
}
