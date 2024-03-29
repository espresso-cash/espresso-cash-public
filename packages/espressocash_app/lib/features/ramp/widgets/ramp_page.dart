import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/form_page.dart';
import '../models/ramp_type.dart';

class RampPage extends StatelessWidget {
  const RampPage({
    super.key,
    required this.type,
    required this.header,
    required this.child,
  });

  final RampType type;
  final Widget header;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final title = switch (type) {
      RampType.onRamp => context.l10n.ramp_btnAddCash,
      RampType.offRamp => context.l10n.ramp_btnCashOut,
    };

    final colorTheme = switch (type) {
      RampType.onRamp => FormPageColorTheme.orange,
      RampType.offRamp => FormPageColorTheme.gold,
    };

    return FormPage(
      title: Text(title.toUpperCase()),
      colorTheme: colorTheme,
      header: header,
      child: child,
    );
  }
}
