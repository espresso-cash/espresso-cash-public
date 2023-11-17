import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../ui/back_button.dart';
import '../../ui/colors.dart';
import 'presentation/footer.dart';

class LandingMobileWidget extends StatelessWidget {
  const LandingMobileWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(color: Color(0xffB4A270)),
        child: Stack(
          children: [
            Align(
              child: Assets.images.dollarBg.image(
                fit: BoxFit.fitHeight,
                height: double.infinity,
                alignment: Alignment.center,
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: constraints.copyWith(
                    minHeight: constraints.maxHeight,
                    maxHeight: double.infinity,
                  ),
                  child: IntrinsicHeight(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(children: children),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Footer(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class LandingDesktopWidget extends StatelessWidget {
  const LandingDesktopWidget({
    super.key,
    required this.content,
    required this.header,
  });

  final Widget header;
  final Widget content;

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(color: Color(0xffB4A270)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Assets.images.logo.image(height: 50),
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: const ShapeDecoration(
                            color: CpColors.yellowDarkAccentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          child: header,
                        ),
                        Expanded(child: content),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Footer(textColor: Color(0xFFBDBDBD)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class HeaderDesktop extends StatelessWidget {
  const HeaderDesktop({
    super.key,
    required this.title,
    this.trailing,
    this.showBackButton = false,
  });

  final String title;
  final Widget? trailing;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showBackButton)
              const CpBackButton()
            else
              const SizedBox.shrink(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF2D2B2C),
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      );
}
