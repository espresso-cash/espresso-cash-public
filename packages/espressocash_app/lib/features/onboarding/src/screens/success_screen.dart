import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../l10n/l10n.dart';
import '../../../../../../ui/button.dart';
import '../../../../../../ui/theme.dart';
import '../../../../routes.gr.dart';

@RoutePage()
class OnboardingSuccessScreen extends StatelessWidget {
  const OnboardingSuccessScreen({super.key, required this.onDone});

  final VoidCallback onDone;

  static const route = OnboardingSuccessRoute.new;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, viewportConstraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const _Header(),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: CpButton(
                          size: CpButtonSize.big,
                          width: double.infinity,
                          text: 'Finish',
                          onPressed: onDone,
                        ),
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Assets.images.sendManualBg.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.center,
              child: Assets.icons.successCheck2.svg(height: 103, width: 103),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.backupPhrase_lblSuccessMessage1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.23,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.l10n.backupPhrase_lblSuccessMessage2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.19,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
