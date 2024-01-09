import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../ui/colors.dart';

class QuizIndicator extends StatelessWidget {
  const QuizIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  final AnimationController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    const effect = ExpandingDotsEffect(
      activeDotColor: CpColors.yellowColor,
      dotColor: Colors.white,
      dotHeight: 7,
      dotWidth: 25,
      expansionFactor: 2.4,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, offset, _) => SmoothIndicator(
          size: effect.calculateSize(count),
          offset: offset,
          count: count,
          effect: effect,
        ),
      ),
    );
  }
}
