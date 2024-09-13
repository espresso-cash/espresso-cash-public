import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/amount_keypad/amount_keypad.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/number_formatter.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/widgets/amount_with_equivalent.dart';
import '../../currency/models/amount.dart';
import '../../tokens/token.dart';

class WalletMainScreen extends StatefulWidget {
  const WalletMainScreen({
    super.key,
    required this.onScan,
    required this.onAmountChanged,
    required this.onRequest,
    required this.onPay,
    required this.amount,
    required this.token,
    this.shakeKey,
    this.error = '',
  });

  final VoidCallback onScan;
  final VoidCallback onRequest;
  final VoidCallback onPay;
  final ValueSetter<Decimal> onAmountChanged;
  final FiatAmount amount;
  final Token token;
  final Key? shakeKey;
  final String error;

  @override
  State<WalletMainScreen> createState() => _ScreenState();
}

class _ScreenState extends State<WalletMainScreen> {
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _amountController.addListener(_updateValue);
  }

  @override
  void dispose() {
    _amountController
      ..removeListener(_updateValue)
      ..dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WalletMainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newAmount = widget.amount.decimal;
    final locale = DeviceLocale.localeOf(context);
    final currentAmount = _amountController.text.toDecimalOrZero(locale);
    if (newAmount != oldWidget.amount.decimal && newAmount != currentAmount) {
      _amountController.text = newAmount.toString();
    }
  }

  void _updateValue() {
    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);
    widget.onAmountChanged(amount);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return CpTheme.black(
      child: Scaffold(
        appBar: _AppBar(onQrScanner: widget.onScan),
        body: SafeArea(
          child: Column(
            children: [
              AmountWithEquivalent(
                inputController: _amountController,
                token: widget.token,
                collapsed: false,
                shakeKey: widget.shakeKey,
                error: widget.error,
                showUsdcInfo: true,
              ),
              Expanded(
                child: AmountKeypad(
                  controller: _amountController,
                  maxDecimals: 2,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CpButton(
                        text: context.l10n.receive,
                        minWidth: width,
                        onPressed: widget.onRequest,
                        size: CpButtonSize.big,
                      ),
                    ),
                    const SizedBox(width: 27.0),
                    Expanded(
                      child: CpButton(
                        text: context.l10n.pay,
                        minWidth: width,
                        onPressed: widget.onPay,
                        size: CpButtonSize.big,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.onQrScanner});

  final VoidCallback onQrScanner;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          left: 4.0,
        ),
        child: CpAppBar(
          leading: Center(
            child: CpIconButton(
              onPressed: onQrScanner,
              icon: Assets.icons.qrScanner.svg(color: Colors.white),
              variant: CpIconButtonVariant.black,
            ),
          ),
        ),
      );
}

enum WalletOperation { pay, request }
