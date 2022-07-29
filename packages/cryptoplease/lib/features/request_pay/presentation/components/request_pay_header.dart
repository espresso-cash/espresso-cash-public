import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/token_display.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:flutter/material.dart';

class RequestPayHeader extends StatelessWidget {
  const RequestPayHeader({
    Key? key,
    required this.amount,
    required this.isLoading,
  }) : super(key: key);

  final CryptoAmount amount;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final formatted = amount.format(locale, skipSymbol: true);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: FittedBox(
            child: Text(
              formatted,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 57,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox.square(dimension: 16),
        TokenDisplay(
          selectedToken: amount.token,
          suffixWidget: isLoading
              ? const CircularProgressIndicator()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
