import 'package:flutter/material.dart';

import '../../../../core/amount.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/colors.dart';

class AvailableBalance extends StatelessWidget {
  const AvailableBalance({
    super.key,
    required this.maxAmountAvailable,
    required this.onMaxAmountRequested,
  });

  final CryptoAmount maxAmountAvailable;
  final VoidCallback? onMaxAmountRequested;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final formatted = maxAmountAvailable.format(locale, roundInteger: true);

    return InkWell(
      onTap: onMaxAmountRequested,
      child: Text(
        context.l10n.swapAmountAvailable(formatted),
        style: TextStyle(
          height: 1.3,
          fontSize: 14.5,
          color: CpColors.greyDarkAccentColor,
          decoration: onMaxAmountRequested == null
              ? TextDecoration.none
              : TextDecoration.underline,
        ),
      ),
    );
  }
}
