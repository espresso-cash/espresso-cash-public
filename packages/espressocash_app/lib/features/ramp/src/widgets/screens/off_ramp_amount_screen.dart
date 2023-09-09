import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/currency.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/amount_keypad/amount_keypad.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/back_button.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/theme.dart';

typedef AmountCalculator = AsyncResult<FiatAmount> Function(
  CryptoAmount amount,
);

@RoutePage()
class OffRampAmountScreen extends StatefulWidget {
  const OffRampAmountScreen({
    super.key,
    required this.onSubmitted,
    required this.minAmount,
    required this.currency,
    required this.calculateEquivalent,
  });

  static const route = OffRampAmountRoute.new;

  final ValueSetter<CryptoAmount> onSubmitted;
  final Decimal minAmount;
  final CryptoCurrency currency;
  final AmountCalculator calculateEquivalent;

  @override
  State<OffRampAmountScreen> createState() => _OffRampAmountScreenState();
}

class _OffRampAmountScreenState extends State<OffRampAmountScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  CryptoAmount get _amount {
    final text = _controller.text;
    final value = Decimal.tryParse(text);

    return value == null
        ? CryptoAmount(value: 0, cryptoCurrency: widget.currency)
        : CryptoAmount(
            value: widget.currency.decimalToInt(value),
            cryptoCurrency: widget.currency,
          );
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            leading: const CpBackButton(),
            title: Text(context.l10n.ramp_btnCashOut.toUpperCase()),
          ),
          body: SafeArea(
            top: false,
            minimum: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    height: 82,
                    child: ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, value, child) => FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          value.text.isEmpty
                              ? context.l10n.enterAmount
                              : '${value.text} ${widget.currency.symbol}',
                          style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.w700,
                            color: value.text.isEmpty
                                ? const Color(0xFF8F8F8F)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 27),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 55,
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    shape: StadiumBorder(),
                    color: Colors.black,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, value, child) {
                        final amount = _amount;

                        return DefaultTextStyle(
                          style: const TextStyle(fontSize: 15),
                          child: amount.decimal < widget.minAmount
                              ? Text(
                                  context.l10n.minAmountToOffRamp(
                                    CryptoAmount(
                                      value: widget.currency
                                          .decimalToInt(widget.minAmount),
                                      cryptoCurrency: widget.currency,
                                    ).format(
                                      DeviceLocale.localeOf(context),
                                      roundInteger: true,
                                    ),
                                  ),
                                )
                              : _Calculator(
                                  calculateEquivalent:
                                      widget.calculateEquivalent,
                                  amount: amount,
                                ),
                        );
                      },
                    ),
                  ),
                ),
                const Spacer(),
                AmountKeypad(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  controller: _controller,
                  maxDecimals: 2,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (context, value, child) {
                      final amount = _amount;

                      return CpButton(
                        width: double.infinity,
                        text: context.l10n.next,
                        onPressed: amount.decimal >= widget.minAmount
                            ? () => widget.onSubmitted(amount)
                            : null,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

class _Calculator extends StatefulWidget {
  const _Calculator({
    required this.calculateEquivalent,
    required this.amount,
  });

  final AmountCalculator calculateEquivalent;
  final CryptoAmount amount;

  @override
  State<_Calculator> createState() => __CalculatorState();
}

class __CalculatorState extends State<_Calculator> {
  AsyncResult<FiatAmount>? _result;

  @override
  void initState() {
    super.initState();
    _result = widget.calculateEquivalent(widget.amount);
  }

  @override
  void didUpdateWidget(covariant _Calculator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.amount == widget.amount) return;

    _result = widget.calculateEquivalent(widget.amount);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _result,
        builder: (context, snapshot) {
          final data = snapshot.data;

          return data == null ||
                  snapshot.connectionState != ConnectionState.done
              ? Text(context.l10n.loading)
              : Text(
                  data.fold(
                    (_) => context.l10n.rampAmountEquivalentError,
                    (amount) => context.l10n.rampAmountEquivalent(
                      amount.format(DeviceLocale.localeOf(context)),
                    ),
                  ),
                );
        },
      );
}
