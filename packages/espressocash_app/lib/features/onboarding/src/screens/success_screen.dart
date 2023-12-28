import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../l10n/l10n.dart';
import '../../../../../../ui/button.dart';
import '../../../../../../ui/content_padding.dart';
import '../../../../../../ui/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/rounded_rectangle.dart';

@RoutePage()
class OnboardingSuccessScreen extends StatelessWidget {
  const OnboardingSuccessScreen({super.key, required this.onDone});

  final VoidCallback onDone;

  static const route = OnboardingSuccessRoute.new;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          body: CpContentPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 110),
                Assets.icons.successCheck.svg(width: 72, height: 72),
                const SizedBox(height: 42),
                CpRoundedRectangle(
                  padding: const EdgeInsets.all(32),
                  backgroundColor: Colors.black,
                  child: Text(
                    '${context.l10n.backupPhrase_lblSuccessMessage1}\n\n${context.l10n.backupPhrase_lblSuccessMessage2}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                CpButton(
                  size: CpButtonSize.big,
                  width: double.infinity,
                  text: context.l10n.ok,
                  onPressed: onDone,
                ),
              ],
            ),
          ),
        ),
      );
}
