import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import 'swap_fee.dart';

class EquivalentHeader extends StatelessWidget {
  const EquivalentHeader({
    super.key,
    required this.inputAmount,
    required this.outputAmount,
    required this.isLoadingRoute,
    required this.feeAmount,
  });

  final CryptoAmount inputAmount;
  final CryptoAmount outputAmount;
  final bool isLoadingRoute;
  final CryptoAmount feeAmount;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (isLoadingRoute) {
      content = const _Loading();
    } else if (inputAmount.value == 0) {
      content = const SizedBox.shrink();
    } else {
      final locale = DeviceLocale.localeOf(context);
      final formattedInput = inputAmount.format(locale, roundInteger: true);
      final formattedOutput = outputAmount.format(
        locale,
        roundInteger: true,
        skipSymbol: false,
      );

      content = FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.swapEquivalent(formattedInput, formattedOutput),
              maxLines: 1,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 6),
            SwapFee(amount: feeAmount)
          ],
        ),
      );
    }

    return Container(
      height: 40,
      margin: const EdgeInsets.all(8),
      child: content,
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => const Center(
        child: SizedBox.square(
          dimension: 16,
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
}
