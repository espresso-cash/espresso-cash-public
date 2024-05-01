import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/amount_keypad/amount_keypad.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bordered_row.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/number_formatter.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/widgets/amount_with_equivalent.dart';
import '../../fees/models/fee_type.dart';
import '../../fees/widgets/fee_label.dart';
import '../../tokens/token.dart';

class ODPConfirmationScreen extends StatefulWidget {
  const ODPConfirmationScreen({
    super.key,
    required this.initialAmount,
    required this.recipient,
    required this.label,
    required this.token,
    this.isEnabled = true,
  });

  static Future<Decimal?> push(
    BuildContext context, {
    required String initialAmount,
    required Ed25519HDPublicKey recipient,
    String? label,
    required Token token,
    required bool isEnabled,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ODPConfirmationScreen(
            initialAmount: initialAmount,
            recipient: recipient,
            label: label,
            token: token,
            isEnabled: isEnabled,
          ),
        ),
      );

  final String initialAmount;
  final Ed25519HDPublicKey recipient;
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

  void _handleSubmitted() {
    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);
    if (amount == Decimal.zero) {
      showWarningDialog(
        context,
        title: context.l10n.zeroAmountTitle,
        message: context.l10n.zeroAmountMessage(context.l10n.operationSend),
      );
    } else {
      Navigator.pop(context, amount);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final address = widget.recipient.toBase58();

    return CpTheme.black(
      child: Scaffold(
        appBar: const CpAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              CpBorderedRow(
                title: Text(context.l10n.to),
                content: BorderedRowChip(
                  backgroundColor: Colors.black,
                  child: Text(
                    '${substring(address, 0, 4)}'
                    '\u2026'
                    '${substring(address, address.length - 4)}',
                  ),
                ),
                dividerColor: CpColors.darkDividerColor,
              ),
              CpBorderedRow(
                title: Text(context.l10n.sendAs),
                content: BorderedRowChip(
                  backgroundColor: Colors.black,
                  child: Text(widget.token.symbol, style: _textStyle),
                ),
                dividerColor: CpColors.darkDividerColor,
              ),
              const SizedBox(height: 38),
              AmountWithEquivalent(
                inputController: _amountController,
                token: widget.token,
                collapsed: widget.isEnabled,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => widget.isEnabled
                      ? AmountKeypad(
                          controller: _amountController,
                          maxDecimals: 2,
                        )
                      : SizedBox(height: constraints.maxHeight),
                ),
              ),
              const SizedBox(height: 16),
              FeeLabel(type: FeeType.direct(widget.recipient)),
              const SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: CpButton(
                  text: context.l10n.pay,
                  minWidth: width,
                  onPressed: _handleSubmitted,
                  size: CpButtonSize.big,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

const _textStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
);
