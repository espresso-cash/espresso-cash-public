import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../ui/colors.dart';

class QuizIndicator extends StatelessWidget {
  const QuizIndicator({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: SmoothPageIndicator(
          controller: PageController(initialPage: index),
          count: 3,
          effect: const ExpandingDotsEffect(
            activeDotColor: CpColors.yellowColor,
            dotColor: Colors.white,
            dotHeight: 7,
            dotWidth: 25,
            expansionFactor: 2.4,
          ),
        ),
      );
}
