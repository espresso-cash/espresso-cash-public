import 'package:cryptoplease/app/components/info_icon.dart';
import 'package:cryptoplease/app/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/app/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/app/ui/button.dart';
import 'package:cryptoplease/app/ui/info_widget.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/odp_header.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class WalletMainScreen extends StatefulWidget {
  const WalletMainScreen({
    super.key,
    required this.onScan,
    required this.onAmountChanged,
    required this.onRequest,
    required this.onPay,
    required this.amount,
  });

  final VoidCallback onScan;
  final VoidCallback onRequest;
  final VoidCallback onPay;
  final ValueSetter<Decimal> onAmountChanged;
  final CryptoAmount amount;

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
    _amountController.removeListener(_updateValue);
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
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _QrScannerAppBar(onQrScanner: widget.onScan),
      body: Column(
        children: [
          ODPHeader(
            inputController: _amountController,
            token: widget.amount.currency.token,
            collapsed: false,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 40,
            ),
            child: CpInfoWidget(
              icon: const InfoIcon(),
              message: Text(
                context.l10n.usdcExplanation,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            ),
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) => EnterAmountKeypad(
                height: constraints.maxHeight,
                width: width,
                controller: _amountController,
                maxDecimals: 2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                Flexible(
                  child: CpButton(
                    text: context.l10n.receive,
                    minWidth: width,
                    onPressed: widget.onRequest,
                    size: CpButtonSize.big,
                  ),
                ),
                const SizedBox(width: 24),
                Flexible(
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
          const SizedBox(height: cpNavigationBarheight + 24),
        ],
      ),
    );
  }
}

class _QrScannerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _QrScannerAppBar({
    Key? key,
    required this.onQrScanner,
  }) : super(key: key);

  final VoidCallback onQrScanner;

  @override
  Size get preferredSize => const Size.fromHeight(2 * kToolbarHeight);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 28, top: 12),
          child: Row(
            children: [
              SizedBox.square(
                dimension: 26,
                child: IconButton(
                  onPressed: onQrScanner,
                  icon: Assets.icons.qrScanner.svg(height: 26),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      );
}
