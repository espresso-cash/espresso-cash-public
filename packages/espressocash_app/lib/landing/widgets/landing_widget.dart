import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import 'extensions.dart';
import 'footer.dart';

class LandingScreenWidget extends StatelessWidget {
  const LandingScreenWidget({super.key, required this.children});

  final List<Widget> children;

  AssetGenImage get backgroundImage =>
      isMobile ? Assets.landing.bgMobile : Assets.landing.bgDesktop;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(gradient: _bgGradient),
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: backgroundImage.image(alignment: Alignment.bottomCenter),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: constraints.copyWith(
                      minHeight: constraints.maxHeight,
                      maxHeight: double.infinity,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: Column(
                            children: [
                              ...children,
                              const Spacer(),
                              const Footer(),
                            ],
                          ),
                        ),
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

const _bgGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xffE36E0A), Color(0xffC8B57D)],
);
