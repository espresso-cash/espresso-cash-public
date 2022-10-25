import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/info_icon.dart';
import 'package:cryptoplease/ui/info_widget.dart';
import 'package:flutter/material.dart';

class UsdcInfoWidget extends StatelessWidget {
  const UsdcInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Samsung Galaxy S20 and larger are good enough to show the full-size
    // version of the widget.
    final isSmall = screenHeight < 800;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isSmall ? 4 : 8,
        horizontal: isSmall ? 20 : 60,
      ),
      child: CpInfoWidget(
        icon: const CpInfoIcon(),
        message: Text(
          context.l10n.usdcExplanation,
          style: TextStyle(
            fontSize: isSmall ? 12 : 14.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        padding: EdgeInsets.all(isSmall ? 12 : 20),
      ),
    );
  }
}
