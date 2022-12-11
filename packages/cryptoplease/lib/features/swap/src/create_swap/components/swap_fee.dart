import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';

class SwapFee extends StatelessWidget {
  const SwapFee({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final CryptoAmount amount;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final formatted = amount.format(locale);

    return Text(
      context.l10n.feeAmount(formatted),
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
