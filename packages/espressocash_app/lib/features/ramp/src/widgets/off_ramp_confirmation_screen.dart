import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../../core/currency.dart';
import '../../../../core/fee_label.dart';
import '../../../../core/tokens/token.dart';
import '../../../../l10n/decimal_separator.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/bordered_row.dart';
import '../../../../ui/button.dart';
import '../../../../ui/number_formatter.dart';
import '../../../../ui/theme.dart';

@RoutePage()
class OffRampConfirmationScreen extends StatefulWidget {
  const OffRampConfirmationScreen({
    super.key,
    required this.amount,
    required this.recipient,
    required this.provider,
    required this.token,
  });

  final String amount;
  final Ed25519HDPublicKey recipient;
  final String provider;
  final Token token;

  @override
  State<OffRampConfirmationScreen> createState() =>
      _OffRampConfirmationScreenState();
}

class _OffRampConfirmationScreenState extends State<OffRampConfirmationScreen> {
  void _onSubmit() {
    context.router.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final address = widget.recipient.toBase58();

    final sign = Currency.usd.sign;
    final amount = widget.amount.formatted(context);
    final formatted = '$sign$amount';

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(),
        body: Column(
          children: [
            CpBorderedRow(
              title: Text(context.l10n.to),
              content: BorderedRowChip(
                child: Text(
                  '${substring(address, 0, 6)}'
                  '\u2026'
                  '${substring(address, address.length - 6)}',
                  style: _textStyle,
                ),
              ),
            ),
            CpBorderedRow(
              title: const Text('Provider'),
              content: BorderedRowChip(
                child: Text(widget.provider, style: _textStyle),
              ),
            ),
            CpBorderedRow(
              title: Text(context.l10n.sendAs),
              content: BorderedRowChip(
                child: Text(widget.token.symbol, style: _textStyle),
              ),
            ),
            const SizedBox(height: 38),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: FittedBox(
                child: Text(
                  formatted,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const Spacer(),
            FeeLabel(type: FeeType.direct(widget.recipient)),
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CpButton(
                text: 'Send',
                minWidth: width,
                onPressed: _onSubmit,
                size: CpButtonSize.big,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

extension on String {
  String formatted(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final decimalSeparator = getDecimalSeparator(locale);
    final value = toDecimalOrZero(locale);

    if (contains(decimalSeparator)) {
      return this;
    } else if (value.toDouble() == 0) {
      return '0';
    }

    return this;
  }
}

const _textStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
);
