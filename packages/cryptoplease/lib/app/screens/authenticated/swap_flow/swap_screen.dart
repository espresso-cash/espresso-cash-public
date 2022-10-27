import 'package:cryptoplease/app/screens/authenticated/swap_flow/components/available_balance.dart';
import 'package:cryptoplease/app/screens/authenticated/swap_flow/components/equivalent_header.dart';
import 'package:cryptoplease/app/screens/authenticated/swap_flow/components/slippage_info.dart';
import 'package:cryptoplease/app/screens/authenticated/swap_flow/components/token_dropdown.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/l10n/decimal_separator.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/amount_keypad/amount_keypad.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease/ui/number_formatter.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({
    Key? key,
    required this.inputAmount,
    required this.outputAmount,
    required this.displayAmount,
    required this.maxAmountAvailable,
    required this.slippage,
    required this.onSlippageChanged,
    required this.onAmountChanged,
    required this.onEditingModeToggled,
    required this.onSubmit,
    required this.isLoadingRoute,
    required this.title,
  }) : super(key: key);

  final CryptoAmount inputAmount;
  final CryptoAmount outputAmount;
  final CryptoAmount displayAmount;
  final CryptoAmount maxAmountAvailable;
  final Decimal slippage;
  final VoidCallback onSubmit;
  final ValueSetter<Decimal> onSlippageChanged;
  final ValueSetter<Decimal> onAmountChanged;
  final VoidCallback onEditingModeToggled;
  final bool isLoadingRoute;
  final String title;

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_updateValue);
  }

  void _updateValue() {
    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);
    if (amount.toString() == widget.displayAmount.decimal.toString()) return;
    widget.onAmountChanged(amount);
  }

  @override
  void didUpdateWidget(covariant SwapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newAmount = widget.displayAmount.decimal;
    final locale = DeviceLocale.localeOf(context);
    final currentAmount = _amountController.text.toDecimalOrZero(locale);
    if (newAmount != oldWidget.displayAmount.decimal &&
        newAmount != currentAmount) {
      _amountController.text = widget.displayAmount.format(
        locale,
        skipSymbol: true,
        decimals: 2,
      );
    }
  }

  @override
  void dispose() {
    _amountController.removeListener(_updateValue);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarBrightness: Brightness.dark,
        ),
        child: CpTheme.dark(
          child: Scaffold(
            backgroundColor: CpColors.darkBackground,
            appBar: CpAppBar(
              leading: const CloseButton(),
              title: Text(widget.title),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _amountController,
                    builder: (context, value, __) => _DisplayHeader(
                      displayAmount: value.text,
                    ),
                  ),
                  EquivalentHeader(
                    displayAmount: widget.displayAmount,
                    inputAmount: widget.inputAmount,
                    outputAmount: widget.outputAmount,
                    isLoadingRoute: widget.isLoadingRoute,
                  ),
                  TokenDropDown(
                    current: widget.displayAmount.token,
                    onTokenChanged: (_) => widget.onEditingModeToggled(),
                    availableTokens: [
                      widget.inputAmount.token,
                      widget.outputAmount.token,
                    ],
                  ),
                  AvailableBalance(
                    maxAmountAvailable: widget.maxAmountAvailable,
                  ),
                  SlippageInfo(
                    slippage: widget.slippage,
                    onSlippageChanged: widget.onSlippageChanged,
                  ),
                  Flexible(
                    child: LayoutBuilder(
                      builder: (context, constraints) => AmountKeypad(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        controller: _amountController,
                        maxDecimals: widget.displayAmount.token.decimals,
                      ),
                    ),
                  ),
                  _Button(
                    onSubmit: widget.onSubmit,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _DisplayHeader extends StatelessWidget {
  const _DisplayHeader({
    Key? key,
    required this.displayAmount,
  }) : super(key: key);

  final String displayAmount;

  @override
  Widget build(BuildContext context) {
    final formatted = displayAmount.formatted(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: FittedBox(
        child: Text(
          formatted,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) => CpContentPadding(
        child: CpButton(
          text: context.l10n.pressAndHoldToSubmit,
          mechanics: CpButtonMechanics.pressAndHold,
          width: double.infinity,
          size: CpButtonSize.big,
          onPressed: onSubmit,
        ),
      );
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
