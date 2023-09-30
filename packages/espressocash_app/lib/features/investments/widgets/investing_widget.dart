import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/theme.dart';
import '../screens/investments_screen.dart';

class InvestingWidget extends StatelessWidget {
  const InvestingWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text(
                'Investing',
                style: dashboardSectionTitleTextStyle,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => context.router.push(InvestmentsScreen.route()),
              child: Assets.images.investingBanner.image(),
            ),
          ],
        ),
      );
}
