import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import 'button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    super.key,
    this.footer = const SizedBox.shrink(),
    required this.children,
  });

  final Widget footer;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: constraints.copyWith(
                minHeight: constraints.maxHeight,
                maxHeight: double.infinity,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    ...children,
                    Expanded(
                      child: footer,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

extension on BuildContext {
  bool get isSmall => MediaQuery.sizeOf(this).width < 400;
}

class OnboardingPadding extends StatelessWidget {
  const OnboardingPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: context.isSmall ? 16 : 32),
        child: child,
      );
}

class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: context.isSmall ? 24 : 45,
          right: context.isSmall ? 24 : 45,
          bottom: 26,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            height: 1.3,
            letterSpacing: .25,
          ),
        ),
      );
}

class OnboardingDescription extends StatelessWidget {
  const OnboardingDescription({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: context.isSmall ? 32 : 54,
          right: context.isSmall ? 32 : 54,
          bottom: 32,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.3,
            letterSpacing: .25,
          ),
        ),
      );
}

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 48),
        child: Assets.images.logoIcon.image(height: 101),
      );
}

class OnboardingFooterButton extends StatelessWidget {
  const OnboardingFooterButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28),
          child: CpButton(
            minWidth: 166,
            text: text,
            onPressed: onPressed,
          ),
        ),
      );
}
