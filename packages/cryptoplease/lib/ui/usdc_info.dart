import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/info_widget.dart';
import 'package:flutter/material.dart';

class UsdcInfoWidget extends StatelessWidget {
  const UsdcInfoWidget({
    Key? key,
    required this.isSmall,
  }) : super(key: key);

  final bool isSmall;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: isSmall ? 20 : 60,
        ),
        child: CpInfoWidget(
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
