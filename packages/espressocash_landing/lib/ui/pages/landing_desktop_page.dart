import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../back_button.dart';
import '../colors.dart';
import '../footer.dart';

class LandingDesktopPage extends StatelessWidget {
  const LandingDesktopPage({
    super.key,
    required this.content,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget content;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: constraints.copyWith(
                    minHeight: constraints.maxHeight,
                    maxHeight: double.infinity,
                    maxWidth: 750,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: EcLandingColors.borderColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: IntrinsicHeight(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: EcLandingColors.borderColor,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            children: [
                              const _AppBar(),
                              _TitleHeader(title: title, subtitle: subtitle),
                              Expanded(child: content),
                              const Padding(
                                padding: EdgeInsets.only(top: 16, bottom: 30),
                                child: Footer(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _TitleHeader extends StatelessWidget {
  const _TitleHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (subtitle case final subtitle?)
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.23,
                ),
              ),
          ],
        ),
      );
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 8),
                child: CpBackButton(
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Assets.images.logoDark.image(height: 51),
            ),
          ],
        ),
      );
}
