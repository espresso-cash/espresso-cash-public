import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/colors.dart';

class AvailableBalance extends StatelessWidget {
  const AvailableBalance({
    Key? key,
    required this.maxAmountAvailable,
  }) : super(key: key);

  final CryptoAmount maxAmountAvailable;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final formatted = maxAmountAvailable.format(locale, roundInteger: true);

    return Text(
      context.l10n.swapAmountAvailable(formatted),
      style: const TextStyle(
        height: 1.3,
        fontSize: 14.5,
        color: CpColors.greyDarkAccentColor,
      ),
    );
  }
}
