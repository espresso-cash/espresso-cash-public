import 'package:flutter/material.dart';

import '../../../../core/amount.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../ui/colors.dart';

class BalancePillWidget extends StatelessWidget {
  const BalancePillWidget(
    this.amount, {
    Key? key,
  }) : super(key: key);

  final Amount amount;

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12,
          ),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: CpColors.lightBackgroundColor,
          ),
          child: Center(
            widthFactor: 1,
            child: Text(
              amount.format(DeviceLocale.localeOf(context)),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
          ),
        ),
      );
}
