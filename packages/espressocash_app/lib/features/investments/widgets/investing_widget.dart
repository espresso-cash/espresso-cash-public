import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/theme.dart';
import '../screens/investments_screen.dart';
import 'home_widget.dart';

class InvestingWidget extends StatelessWidget {
  const InvestingWidget({super.key});

  @override
  Widget build(BuildContext context) => HomeTile(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                context.l10n.investingTitle,
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
