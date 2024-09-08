import 'package:country_flags/country_flags.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/amount_keypad/amount_keypad.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';
import '../models/ramp_type.dart';
import 'debounce_mixin.dart';

typedef AmountCalculator = AsyncResult<Amount> Function(Amount amount);
typedef RampFees = ({String? ourFee, String? partnerFee, Amount? totalFee});
typedef FeeCalculator = AsyncResult<RampFees> Function(Amount amount);

class RampAmountScreen extends StatefulWidget {
  const RampAmountScreen({
    super.key,
    required this.onSubmitted,
    required this.minAmount,
    required this.currency,
    required this.calculateEquivalent,
    required this.type,
    required this.calculateFee,
    required this.partner,
    required this.exchangeRate,
  });

  static Future<void> push(
    BuildContext context, {
    required ValueSetter<Amount> onSubmitted,
    required Decimal minAmount,
    required Currency currency,
    required RampType type,
    required RampPartner partner,
    AmountCalculator? calculateEquivalent,
    FeeCalculator? calculateFee,
    String? exchangeRate,
  }) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => RampAmountScreen(
            onSubmitted: onSubmitted,
            minAmount: minAmount,
            currency: currency,
            calculateEquivalent: calculateEquivalent,
            type: type,
            partner: partner,
            calculateFee: calculateFee,
            exchangeRate: exchangeRate,
          ),
        ),
      );

  final ValueSetter<Amount> onSubmitted;
  final Decimal minAmount;
  final Currency currency;
  final AmountCalculator? calculateEquivalent;
  final RampType type;
  final RampPartner partner;
  final FeeCalculator? calculateFee;

  final String? exchangeRate;

  @override
  State<RampAmountScreen> createState() => _RampAmountScreenState();
}

class _RampAmountScreenState extends State<RampAmountScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Amount get _amount {
    final text = _controller.text;
    final value = Decimal.tryParse(text);

    return value == null
        ? Amount(value: 0, currency: widget.currency)
        : Amount(
            value: widget.currency.decimalToInt(value),
            currency: widget.currency,
          );
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            leading: const CpBackButton(),
            title: Text(
              switch (widget.type) {
                RampType.onRamp => context.l10n.ramp_btnAddCash,
                RampType.offRamp => context.l10n.ramp_btnCashOut,
              }
                  .toUpperCase(),
            ),
          ),
          body: SafeArea(
            top: false,
            minimum: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _RampTextField(
                        label: widget.type == RampType.offRamp
                            ? 'Withdrawal Amount'
                            : 'Deposit Amount',
                        controller: _controller,
                        currency: widget.currency,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, value, child) =>
                            _EquivalentTextField(
                          amount: _amount,
                          calculateEquivalent: widget.calculateEquivalent,
                          minAmount: widget.minAmount,
                          type: widget.type,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, value, child) =>
                            _AdditionalInfoLabel(
                          feeCalculator: widget.calculateFee,
                          amount: _amount,
                          exchangeRate: widget.exchangeRate,
                          minAmount: widget.minAmount,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: AmountKeypad(
                            controller: _controller,
                            maxDecimals: 2,
                          ),
                        ),
                      ),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _AdditionalInfoLabel extends StatefulWidget {
  const _AdditionalInfoLabel({
    required this.feeCalculator,
    required this.amount,
    required this.minAmount,
    this.exchangeRate,
  });

  final String? exchangeRate;
  final FeeCalculator? feeCalculator;
  final Amount amount;
  final Decimal minAmount;

  @override
  State<_AdditionalInfoLabel> createState() => _AdditionalInfoLabelState();
}

class _AdditionalInfoLabelState extends State<_AdditionalInfoLabel>
    with DebounceMixin {
  AsyncResult<RampFees>? _result;

  @override
  void initState() {
    super.initState();
    _call();
  }

  @override
  void didUpdateWidget(covariant _AdditionalInfoLabel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.amount == widget.amount) return;

    _call();
  }

  void _call() {
    debounce(() {
      setState(() {
        _result = widget.feeCalculator?.call(widget.amount);
      });
    });
  }

  @override
  Widget build(BuildContext context) =>
      widget.exchangeRate == null && widget.feeCalculator == null
          ? const SizedBox.shrink()
          : _SendInfoContainer(
              content: Column(
                children: [
                  if (widget.exchangeRate case final exchangeRate?)
                    _InfoRow(
                      title: 'Exchange Rate',
                      value: exchangeRate,
                    ),
                  if (widget.feeCalculator != null)
                    FutureBuilder(
                      future: _result,
                      builder: (context, snapshot) {
                        if (widget.amount.decimal < widget.minAmount) {
                          return const Column(
                            children: [
                              _InfoRow(title: 'Our Fee', value: '-'),
                              _InfoRow(title: 'Partner Fee', value: '-'),
                              _InfoRow(title: 'Total Fees', value: '-'),
                            ],
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Column(
                            children: [
                              _ShimmerInfoRow(title: 'Our Fee'),
                              _ShimmerInfoRow(title: 'Partner Fee'),
                              _ShimmerInfoRow(title: 'Total Fees'),
                            ],
                          );
                        }

                        final data = snapshot.data;

                        return data == null || snapshot.hasError
                            ? const SizedBox.shrink()
                            : data.fold(
                                (_) => const SizedBox.shrink(),
                                (data) => Column(
                                  children: [
                                    if (data.ourFee case final ourFee?)
                                      _InfoRow(
                                        title: 'Our Fee',
                                        value: ourFee,
                                      ),
                                    if (data.partnerFee case final partnerFee?)
                                      _InfoRow(
                                        title: 'Partner Fee',
                                        value: partnerFee,
                                      ),
                                    if (data.totalFee case final totalFee?)
                                      _InfoRow(
                                        title: 'Total Fees',
                                        value: totalFee.format(
                                          context.locale,
                                          maxDecimals: 2,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                      },
                    ),
                ],
              ),
            );
}

class _ShimmerInfoRow extends StatelessWidget {
  const _ShimmerInfoRow({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const _SkeletonAnimation(
              height: 16,
              width: 70,
            ),
          ],
        ),
      );
}

class _EquivalentTextField extends StatelessWidget {
  const _EquivalentTextField({
    required this.amount,
    required this.calculateEquivalent,
    required this.type,
    required this.minAmount,
  });

  final Amount amount;
  final AmountCalculator? calculateEquivalent;
  final Decimal minAmount;
  final RampType type;

  @override
  Widget build(BuildContext context) {
    final calculator = calculateEquivalent;

    if (amount.decimal < minAmount || calculateEquivalent == null) {
      return const SizedBox.shrink();
    }

    return calculator == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              const SizedBox(height: 16),
              _Calculator(
                calculateEquivalent: calculator,
                amount: amount,
              ),
            ],
          );
  }
}

class _RampTextField extends StatelessWidget {
  const _RampTextField({
    required this.currency,
    required this.controller,
    required this.label,
  });

  final String label;
  final Currency currency;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final logo = switch (currency) {
      FiatCurrency(:final countryCode) => countryCode != null
          ? CountryFlag.fromCountryCode(
              countryCode,
              shape: const Circle(),
              width: 36,
              height: 36,
            )
          : CircleAvatar(
              backgroundColor: CpColors.darkBackgroundColor,
              child: Assets.icons.money.svg(),
            ),
      CryptoCurrency(:final Token token) => TokenIcon(
          token: token,
          size: 36,
        ),
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 6),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          CpTextField(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            height: 70,
            controller: controller,
            inputType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            backgroundColor: CpColors.darkBackgroundColor,
            placeholder: '0',
            placeholderColor: Colors.white,
            textColor: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            maxLength: 29,
            prefix: logo,
            suffix: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Text(
                currency.symbol,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SendInfoContainer extends StatelessWidget {
  const _SendInfoContainer({
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          decoration: const ShapeDecoration(
            color: CpColors.darkBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(28),
              ),
            ),
          ),
          child: content,
        ),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff999999),
              ),
            ),
          ],
        ),
      );
}

class _Calculator extends StatefulWidget {
  const _Calculator({
    required this.calculateEquivalent,
    required this.amount,
  });

  final AmountCalculator calculateEquivalent;
  final Amount amount;

  @override
  State<_Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<_Calculator> with DebounceMixin {
  AsyncResult<Amount>? _result;

  @override
  void initState() {
    super.initState();
    _call();
  }

  @override
  void didUpdateWidget(covariant _Calculator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.amount == widget.amount) return;

    _call();
  }

  void _call() {
    debounce(() {
      setState(() {
        _result = widget.calculateEquivalent(widget.amount);
      });
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _result,
        builder: (context, snapshot) {
          const label = 'You Receive';
          const loading = LoadingTextField(label: label);

          if (snapshot.connectionState != ConnectionState.done) {
            return loading;
          }

          final data = snapshot.data;

          return data == null
              ? const SizedBox.shrink()
              : data.fold(
                  (_) => loading,
                  (data) => _RampTextField(
                    label: label,
                    controller: FittedTextEditingController(
                      text: data.format(
                        context.locale,
                        maxDecimals: 2,
                        skipSymbol: true,
                      ),
                    ),
                    currency: data.currency,
                  ),
                );
        },
      );
}

class LoadingTextField extends StatelessWidget {
  const LoadingTextField({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: 70,
              decoration: const ShapeDecoration(
                color: CpColors.darkBackgroundColor,
                shape: StadiumBorder(),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: const Row(
                children: [
                  SizedBox(width: 16),
                  SizedBox.square(
                    dimension: 36,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: _SkeletonAnimation(
                      height: 30,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
            ),
          ],
        ),
      );
}

class _SkeletonAnimation extends StatelessWidget {
  const _SkeletonAnimation({
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: const _ShimmerEffect(),
      );
}

class _ShimmerEffect extends StatefulWidget {
  const _ShimmerEffect();

  @override
  _ShimmerEffectState createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey.withOpacity(0.3),
                Colors.grey.withOpacity(0.5),
                Colors.grey.withOpacity(0.3),
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1.0 + (2 * _controller.value), 0.0),
              end: Alignment(1.0 + (2 * _controller.value), 0.0),
            ),
          ),
        ),
      );
}
