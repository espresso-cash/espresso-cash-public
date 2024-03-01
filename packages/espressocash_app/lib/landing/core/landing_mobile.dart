import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import 'presentation/footer.dart';

class LandingMobilePage extends StatelessWidget {
  const LandingMobilePage({
    super.key,
    required this.header,
    required this.content,
  });

  final Widget header;
  final Widget content;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffB4A270),
                  Colors.white,
                ],
                stops: [0.49, 0.5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.33,
                        child: _Header(content: header),
                      ),
                      Expanded(
                        child: ColoredBox(
                          color: Colors.white,
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Expanded(child: content),
                                const Padding(
                                  padding: EdgeInsets.only(top: 16, bottom: 8),
                                  child: Footer(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
  const _Header({
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: const Color(0xffB4A270),
        child: Stack(
          children: [
            Center(
              child: Assets.images.dollarBg.image(
                fit: BoxFit.fitWidth,
                alignment: Alignment.topLeft,
                width: double.infinity,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: content,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Assets.images.logoDark.image(height: 35),
              ),
            ),
          ],
        ),
      );
}
