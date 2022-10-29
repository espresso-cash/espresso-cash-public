import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/tokens/token.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/amount_keypad/amount_keypad.dart';
import '../../../../ui/amount_with_equivalent.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/bordered_row.dart';
import '../../../../ui/button.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/number_formatter.dart';
import '../../../../ui/theme.dart';
import '../../../../ui/usdc_info.dart';

class ODPConfirmationScreen extends StatefulWidget {
  const ODPConfirmationScreen({
    Key? key,
    required this.initialAmount,
    required this.recipient,
    required this.label,
    required this.token,
    this.isEnabled = true,
  }) : super(key: key);

  final String initialAmount;
  final String recipient;
  final String? label;
  final Token token;
  final bool isEnabled;

  @override
  State<ODPConfirmationScreen> createState() => _ScreenState();
}

class _ScreenState extends State<ODPConfirmationScreen> {
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.initialAmount);
  }

  void _onSubmit() {
    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);
    if (amount == Decimal.zero) {
      showWarningDialog(
        context,
        title: context.l10n.zeroAmountTitle,
        message: context.l10n.zeroAmountMessage(context.l10n.operationSend),
      );
    } else {
      context.router.pop(amount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final address = widget.recipient;

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(),
        body: Column(
          children: [
            CpBorderedRow(
              title: Text(context.l10n.to),
              content: BorderedRowChip(
                child: Text(
                  '${substring(address, 0, 4)}'
                  '\u2026'
                  '${substring(address, address.length - 4)}',
                ),
              ),
            ),
            CpBorderedRow(
              title: Text(context.l10n.sendAs),
              content: BorderedRowChip(
                child: Text(widget.token.symbol, style: _textStyle),
              ),
            ),
            const SizedBox(height: 16),
            AmountWithEquivalent(
              inputController: _amountController,
              token: widget.token,
              collapsed: true,
            ),
            const SizedBox(height: 16),
            UsdcInfoWidget(isSmall: height < 700 && widget.isEnabled),
            const SizedBox(height: 8),
            Flexible(
              flex: 3,
              child: LayoutBuilder(
                builder: (context, constraints) => widget.isEnabled
                    ? AmountKeypad(
                        height: constraints.maxHeight,
                        width: width,
                        controller: _amountController,
                        maxDecimals: 2,
                      )
                    : SizedBox(height: constraints.maxHeight),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CpButton(
                text: context.l10n.pay,
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

const _textStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
);
