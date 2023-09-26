import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import 'footer.dart';

class LandingScreenWidget extends StatelessWidget {
  const LandingScreenWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(gradient: _bgGradient),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final image = constraints.maxWidth < 430
                ? Assets.landing.bgMobile
                : Assets.landing.bgDesktop;

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: image.image(
                              alignment: Alignment.bottomCenter,
                              repeat: ImageRepeat.repeatX,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(children: children),
                            ),
                            const Spacer(),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Footer(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}

const _bgGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xffE36E0A), Color(0xffC8B57D)],
);
