import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';

enum AmbassadorResult { success, alreadyRegistered, notAmbassador }

class AmbassadorResultScreen extends StatelessWidget {
  const AmbassadorResultScreen({required this.result, super.key});

  final AmbassadorResult result;

  static void push(BuildContext context, AmbassadorResult result) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => AmbassadorResultScreen(result: result)),
      );

  Color get _backgroundColor =>
      result == AmbassadorResult.success ? CpColors.sandColor : CpColors.lightSandColor;

  Color get _starColor =>
      result == AmbassadorResult.success ? CpColors.lightSandColor : CpColors.sandColor;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: _backgroundColor,
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Assets.icons.starBackground.svg(
                    fit: BoxFit.cover,
                    color: _starColor,
                    width: 600,
                    height: 600,
                  ),
                ),
                Center(
                  child: switch (result) {
                    AmbassadorResult.success => const _SuccessContent(),
                    AmbassadorResult.alreadyRegistered => const _AlreadyRegisteredContent(),
                    AmbassadorResult.notAmbassador => const _NotAmbassadorContent(),
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: CpButton(
              text: context.l10n.ok,
              size: CpButtonSize.big,
              width: 340,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    ),
  );
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent();

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IntrinsicHeight(
        child: Stack(
          children: [
            Center(child: Assets.icons.confetti.svg(width: 315)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Assets.icons.successCheck3.svg(width: 120),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      Text(
        context.l10n.ambassador_enrollmentComplete,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    ],
  );
}

class _AlreadyRegisteredContent extends StatelessWidget {
  const _AlreadyRegisteredContent();

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Assets.icons.errorIcon2.svg(width: 111),
      const SizedBox(height: 24),
      Text(
        context.l10n.ambassador_alreadyEnrolledTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 16),
      Text(
        context.l10n.ambassador_alreadyEnrolledDescription,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.17),
      ),
    ],
  );
}

class _NotAmbassadorContent extends StatelessWidget {
  const _NotAmbassadorContent();

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Assets.icons.errorIcon2.svg(width: 111),
      const SizedBox(height: 24),
      Text(
        context.l10n.ambassador_notAmbassadorTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 16),
      Text(
        context.l10n.ambassador_notAmbassadorDescription,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.17),
      ),
    ],
  );
}
