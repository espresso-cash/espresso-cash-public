import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:flutter/material.dart';

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
