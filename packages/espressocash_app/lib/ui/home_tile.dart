import 'package:flutter/widgets.dart';

import 'colors.dart';

class HomeTile extends StatelessWidget {
  const HomeTile({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: const BoxDecoration(
          color: CpColors.dashboardBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: CpColors.dashboardBackgroundColor,
              blurRadius: 0.0,
              spreadRadius: 0.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: child,
      );
}
