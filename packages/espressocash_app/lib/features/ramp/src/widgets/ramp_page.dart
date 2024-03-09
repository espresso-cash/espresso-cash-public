import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/form_page.dart';
import '../../models/ramp_type.dart';

class RampPage extends StatelessWidget {
  const RampPage({
    super.key,
    required this.headerIcon,
    required this.headerContent,
    required this.content,
    required this.type,
  });

  final AssetGenImage headerIcon;
  final Widget headerContent;
  final Widget content;
  final RampType type;

  @override
  Widget build(BuildContext context) => FormPage(
        title: Text(
          switch (type) {
            RampType.onRamp => context.l10n.ramp_btnAddCash,
            RampType.offRamp => context.l10n.ramp_btnCashOut,
          }
              .toUpperCase(),
        ),
        colorTheme: switch (type) {
          RampType.onRamp => FormPageColorTheme.orange,
          RampType.offRamp => FormPageColorTheme.gold,
        },
        headerContent: headerContent,
        headerIcon: headerIcon,
        content: content,
      );
}
