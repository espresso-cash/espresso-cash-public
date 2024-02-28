import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import 'presentation/footer.dart';

class LandingMobilePage extends StatelessWidget {
  const LandingMobilePage({super.key, required this.children});

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
