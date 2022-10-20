import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/app/screens/authenticated/swap_flow/components/slippage_bottom_sheet.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/l10n/decimal_separator.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/amount_keypad/amount_keypad.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
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
                    builder: (context, value, __) => _Header(
                      displayAmount: value.text,
                    ),
                  ),
                  _Equivalent(
                    displayAmount: widget.displayAmount,
                    inputAmount: widget.inputAmount,
                    outputAmount: widget.outputAmount,
                    isLoadingRoute: widget.isLoadingRoute,
                  ),
                  _TokenDropDown(
                    current: widget.displayAmount.token,
                    onTap: widget.onEditingModeToggled,
                    availableTokens: [
                      widget.inputAmount.token,
                      widget.outputAmount.token,
                    ],
                  ),
                  _AvailableBalance(
                    maxAmountAvailable: widget.maxAmountAvailable,
                  ),
                  _SlippageInfo(
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

class _SlippageInfo extends StatelessWidget {
  const _SlippageInfo({
    Key? key,
    required this.slippage,
    required this.onSlippageChanged,
  }) : super(key: key);

  final Decimal slippage;
  final ValueSetter<Decimal> onSlippageChanged;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () => SlippageBottomSheet.show(context, onSlippageChanged),
          child: Text.rich(
            TextSpan(
              text: context.l10n.swapSlippageWarning,
              children: [
                TextSpan(
                  text: '$slippage%',
                  style: const TextStyle(
                    color: CpColors.yellowDarkAccentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            style: _descriptionStyle,
            textAlign: TextAlign.center,
          ),
        ),
      );
}

class _AvailableBalance extends StatelessWidget {
  const _AvailableBalance({
    Key? key,
    required this.maxAmountAvailable,
  }) : super(key: key);

  final CryptoAmount maxAmountAvailable;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final formatted = maxAmountAvailable.format(locale, roundInteger: true);

    return Text(
      context.l10n.swapAmountAvailable(formatted),
      style: _descriptionStyle,
    );
  }
}

class _TokenDropDown extends StatelessWidget {
  const _TokenDropDown({
    Key? key,
    required this.current,
    required this.onTap,
    required this.availableTokens,
  }) : super(key: key);

  final Token current;
  final VoidCallback onTap;
  final Iterable<Token> availableTokens;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );

    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 24),
      padding: const EdgeInsets.all(16),
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: CpColors.greenDropdown,
      ),
      child: DropdownButton<Token>(
        value: current,
        underline: const SizedBox.shrink(),
        isExpanded: true,
        icon: const Icon(Icons.expand_more),
        dropdownColor: CpColors.greenDropdown,
        style: style,
        items: availableTokens
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Center(child: Text(e.symbol)),
                ),
              ),
            )
            .toList(),
        onChanged: (t) => t == null ? ignore : onTap(),
        selectedItemBuilder: (context) => availableTokens
            .map(
              (t) => Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Center(child: Text(t.symbol)),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
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

class _Equivalent extends StatelessWidget {
  const _Equivalent({
    Key? key,
    required this.inputAmount,
    required this.displayAmount,
    required this.outputAmount,
    required this.isLoadingRoute,
  }) : super(key: key);

  final CryptoAmount inputAmount;
  final CryptoAmount displayAmount;
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
        decimals: 2,
        roundInteger: true,
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

const _descriptionStyle = TextStyle(
  height: 1.3,
  fontSize: 14.5,
  color: CpColors.greyDarkAccentColor,
);

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox.square(
        dimension: 16,
        child: CircularProgressIndicator(color: Colors.white),
      );
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
          mechanic: CpButtonMechanic.hold,
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
