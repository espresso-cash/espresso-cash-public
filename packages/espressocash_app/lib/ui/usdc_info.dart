import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import 'info_widget.dart';

class UsdcInfoWidget extends StatelessWidget {
  const UsdcInfoWidget({
    super.key,
    required this.isSmall,
  });

  final bool isSmall;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: CpInfoWidget(
          message: Text(
            context.l10n.usdcExplanation,
            style: TextStyle(
              fontSize: isSmall ? 12 : 14.5,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 3,
          ),
          variant: CpInfoVariant.black,
          padding: EdgeInsets.all(isSmall ? 14 : 18),
        ),
      );
}
