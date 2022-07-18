import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/stable_token_dropdown.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:flutter/material.dart';

class RequestPayHeader extends StatelessWidget {
  const RequestPayHeader({
    Key? key,
    required this.amount,
    required this.onTokenChanged,
  }) : super(key: key);

  final CryptoAmount amount;
  final VoidCallback onTokenChanged;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final formatted = amount.format(locale, skipSymbol: true);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          StableTokenDropdown(
            onTap: onTokenChanged,
            selectedToken: amount.token,
            suffixWidget: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
