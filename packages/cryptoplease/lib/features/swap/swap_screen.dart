import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/app/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/balances/presentation/watch_balance.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/swap/presentation/components/slippage_bottom_sheet.dart';
import 'package:cryptoplease/l10n/decimal_separator.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({
    Key? key,
    required this.inputAmount,
    required this.outputAmount,
    required this.slippage,
    required this.onSlippageChanged,
    required this.onAmountChanged,
    required this.onSubmit,
    required this.loading,
  }) : super(key: key);

  final CryptoAmount inputAmount;
  final CryptoAmount outputAmount;
  final Decimal slippage;
  final ValueSetter<Decimal> onSlippageChanged;
  final ValueSetter<Decimal> onAmountChanged;
  final VoidCallback onSubmit;
  final bool loading;

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final _amountController = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_updateValue);
  }

  void _updateValue() {
    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);
    widget.onAmountChanged(amount);
  }

  @override
  void didUpdateWidget(covariant SwapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newAmount = widget.inputAmount.decimal;
    final locale = DeviceLocale.localeOf(context);
    final currentAmount = _amountController.text.toDecimalOrZero(locale);
    if (newAmount != oldWidget.inputAmount.decimal &&
        newAmount != currentAmount) {
      _amountController.text = newAmount.toString();
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
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _amountController,
                    builder: (context, _, __) => _Header(
                      inputController: _amountController,
                    ),
                  ),
                  _Equivalent(
                    inputAmount: widget.inputAmount,
                    outputAmount: widget.outputAmount,
                    loading: widget.loading,
                  ),
                  _TokenDropDown(
                    current: widget.inputAmount.token,
                    availableTokens: <Token>[].lock,
                    onTokenChanged: print,
                  ),
                  _AvailableBalance(token: widget.inputAmount.token),
                  _SlippageInfo(
                    slippage: widget.slippage,
                    onSlippageChanged: widget.onSlippageChanged,
                  ),
                  Flexible(
                    child: LayoutBuilder(
                      builder: (context, constraints) => EnterAmountKeypad(
                        height: constraints.maxHeight,
                        width: MediaQuery.of(context).size.width,
                        controller: _amountController,
                        maxDecimals: widget.inputAmount.token.decimals,
                      ),
                    ),
                  ),
                  const _Button(),
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
              text:
                  'Your transaction will be cancelled\nif the price varies more than ',
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
    required this.token,
  }) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) {
    final available = context.watchUserCryptoBalance(token);
    final locale = DeviceLocale.localeOf(context);
    final formatted = available.format(locale, roundInteger: true);

    return Text('$formatted available for use.', style: _descriptionStyle);
  }
}

class _TokenDropDown extends StatelessWidget {
  const _TokenDropDown({
    Key? key,
    required this.current,
    required this.availableTokens,
    required this.onTokenChanged,
  }) : super(key: key);

  final Token current;
  final IList<Token> availableTokens;
  final ValueSetter<Token> onTokenChanged;

  @override
  Widget build(BuildContext context) => Container(
        height: 55,
        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 32),
        padding: const EdgeInsets.all(16),
        decoration: const ShapeDecoration(
          shape: StadiumBorder(),
          color: CpColors.greenDropdown,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Text(
                current.symbol,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Positioned(right: 0, child: Icon(Icons.expand_more)),
          ],
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.inputController,
  }) : super(key: key);

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    final displayAmount = inputController.text.formatted(context);

    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: FittedBox(
              child: Text(
                displayAmount,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 4,
            left: 4,
            child: CloseButton(),
          ),
        ],
      ),
    );
  }
}

class _Equivalent extends StatelessWidget {
  const _Equivalent({
    Key? key,
    required this.inputAmount,
    required this.outputAmount,
    required this.loading,
  }) : super(key: key);

  final CryptoAmount inputAmount;
  final CryptoAmount outputAmount;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (loading) {
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
          'For $formattedInput you will get aprox. $formattedOutput',
          maxLines: 1,
          style: const TextStyle(fontSize: 15),
        ),
      );
    }

    return SizedBox(
      height: 16,
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
  const _Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const CpContentPadding(
        child: CpButton(
          text: 'Press & hold to submit',
          mechanic: CpButtonMechanic.hold,
          width: double.infinity,
          size: CpButtonSize.big,
          onPressed: ignore,
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
