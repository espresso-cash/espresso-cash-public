import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';

class EquivalentHeader extends StatelessWidget {
  const EquivalentHeader({
    Key? key,
    required this.inputAmount,
    required this.outputAmount,
    required this.isLoadingRoute,
  }) : super(key: key);

  final CryptoAmount inputAmount;
  final CryptoAmount outputAmount;
  final bool isLoadingRoute;

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
        child: Text(
          context.l10n.swapEquivalent(formattedInput, formattedOutput),
          maxLines: 1,
          style: const TextStyle(fontSize: 15),
        ),
      );
    }

    return Container(
      height: 16,
      margin: const EdgeInsets.all(8),
      child: content,
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox.square(
        dimension: 16,
        child: CircularProgressIndicator(color: Colors.white),
      );
}
