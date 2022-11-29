import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/amount.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../features/swap/bl/route.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/amount_keypad/amount_keypad.dart';
import '../../../../ui/button.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/number_formatter.dart';
import 'components/available_balance.dart';
import 'components/display_header.dart';
import 'components/equivalent_header.dart';
import 'components/route_duration_wrapper.dart';
import 'components/slippage_info.dart';
import 'components/swap_fee.dart';
import 'components/token_dropdown.dart';

class CreateSwapScreen extends StatefulWidget {
  const CreateSwapScreen({
    Key? key,
    required this.inputAmount,
    required this.outputAmount,
    required this.displayAmount,
    required this.fee,
    required this.maxAmountAvailable,
    required this.slippage,
    required this.isLoadingRoute,
    required this.routeFetchedAt,
    required this.onSlippageChanged,
    required this.onAmountChanged,
    required this.onEditingModeToggled,
    required this.onRouteExpired,
    required this.onSubmit,
  }) : super(key: key);

  final CryptoAmount inputAmount;
  final CryptoAmount outputAmount;
  final CryptoAmount displayAmount;
  final CryptoAmount fee;
  final CryptoAmount maxAmountAvailable;
  final Slippage slippage;
  final bool isLoadingRoute;
  final DateTime? routeFetchedAt;
  final ValueSetter<Slippage> onSlippageChanged;
  final ValueSetter<Decimal> onAmountChanged;
  final VoidCallback onEditingModeToggled;
  final VoidCallback onRouteExpired;
  final VoidCallback onSubmit;

  @override
  State<CreateSwapScreen> createState() => _CreateSwapScreenState();
}

class _CreateSwapScreenState extends State<CreateSwapScreen> {
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
  void didUpdateWidget(covariant CreateSwapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newAmount = widget.displayAmount.decimal;
    final locale = DeviceLocale.localeOf(context);
    final currentAmount = _amountController.text.toDecimalOrZero(locale);
    if (newAmount != oldWidget.displayAmount.decimal &&
        newAmount != currentAmount) {
      _amountController.text = widget.displayAmount.format(
        locale,
        roundInteger: true,
        skipSymbol: true,
      );
    }
  }

  @override
  void dispose() {
    _amountController.removeListener(_updateValue);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _amountController,
              builder: (context, value, __) => DisplayHeader(
                displayAmount: value.text,
              ),
            ),
            EquivalentHeader(
              inputAmount: widget.inputAmount,
              outputAmount: widget.outputAmount,
              isLoadingRoute: widget.isLoadingRoute,
            ),
            SwapFee(amount: widget.fee),
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
            RouteDurationWrapper(
              start: widget.routeFetchedAt,
              onTimeout: widget.onRouteExpired,
              builder: (context, remaining) => _Button(
                countdown: remaining,
                onSubmit: widget.onSubmit,
              ),
            ),
          ],
        ),
      );
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.countdown,
    required this.onSubmit,
  }) : super(key: key);

  final Duration? countdown;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.pressAndHoldToSubmit;
    final label = countdown
        .maybeMap((d) => '$title (${d.inSeconds}s)')
        .ifNull(() => title);

    return CpContentPadding(
      child: CpButton(
        text: label,
        mechanics: CpButtonMechanics.pressAndHold,
        width: double.infinity,
        size: CpButtonSize.big,
        onPressed: countdown != null ? onSubmit : ignore,
      ),
    );
  }
}
