import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/amount_keypad/amount_keypad.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/shake.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../models/ramp_type.dart';
import '../widgets/debounce_mixin.dart';
import '../widgets/error_chip.dart';
import '../widgets/ramp_loader.dart';
import '../widgets/ramp_textfield.dart';

typedef AmountCalculator = AsyncResult<Amount> Function(Amount amount);
typedef RampFees = ({
  String? ourFee,
  String? partnerFee,
  Amount? totalFee,
  Amount? extraFee
});
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
    required this.receiveCurrency,
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
    Currency? receiveCurrency,
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
            receiveCurrency: receiveCurrency,
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
  final Currency? receiveCurrency;

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
            minimum: EdgeInsets.symmetric(vertical: 6.h),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      RampTextField(
                        label: widget.type == RampType.offRamp
                            ? context.l10n.withdrawalAmountTitle
                            : context.l10n.depositAmountTitle,
                        controller: _controller,
                        currency: widget.currency,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, value, child) => _ReceiveTextField(
                          amount: _amount,
                          calculateEquivalent: widget.calculateEquivalent,
                          minAmount: widget.minAmount,
                          type: widget.type,
                          receiveCurrency: widget.receiveCurrency,
                        ),
                      ),
                      SizedBox(height: 14.h),
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
                      ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, value, child) =>
                            _MinimumAmountNotice(
                          controller: _controller,
                          currency: widget.currency,
                          amount: _amount,
                          minAmount: widget.minAmount,
                          type: widget.type,
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 16.h,
                        ),
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
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      );
}

class _MinimumAmountNotice extends StatefulWidget {
  const _MinimumAmountNotice({
    required this.controller,
    required this.amount,
    required this.minAmount,
    required this.type,
    required this.currency,
  });

  final TextEditingController controller;
  final Amount amount;
  final Decimal minAmount;
  final RampType type;
  final Currency currency;

  @override
  State<_MinimumAmountNotice> createState() => _MinimumAmountNoticeState();
}

class _MinimumAmountNoticeState extends State<_MinimumAmountNotice>
    with DebounceMixin {
  final _shakeKey = GlobalKey<ShakeState>();
  bool _visible = false;

  @override
  void didUpdateWidget(covariant _MinimumAmountNotice oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.amount != widget.amount) {
      _updateVisibility();
    }
  }

  void _updateVisibility() {
    final newVisible = widget.amount.decimal != Decimal.zero &&
        widget.amount.decimal < widget.minAmount;
    if (_visible != newVisible) {
      _visible = newVisible;
    }
    if (_visible) {
      _shakeKey.currentState?.shake();
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = Amount(
      value: widget.currency.decimalToInt(widget.minAmount),
      currency: widget.currency,
    ).format(context.locale, roundInteger: true, maxDecimals: 0);

    final message = switch (widget.type) {
      RampType.onRamp => context.l10n.minAmountToOnRamp(amount),
      RampType.offRamp => context.l10n.minAmountToOffRamp(amount),
    }
        .toUpperCase();

    return Shake(
      key: _shakeKey,
      child: ErrorChip(
        text: message,
        visible: _visible,
        margin: EdgeInsets.only(top: 32.h),
      ),
    );
  }
}

class _ReceiveTextField extends StatefulWidget {
  const _ReceiveTextField({
    required this.amount,
    required this.calculateEquivalent,
    required this.type,
    required this.minAmount,
    required this.receiveCurrency,
  });

  final Amount amount;
  final AmountCalculator? calculateEquivalent;
  final Decimal minAmount;
  final RampType type;
  final Currency? receiveCurrency;

  @override
  State<_ReceiveTextField> createState() => _ReceiveTextFieldState();
}

class _ReceiveTextFieldState extends State<_ReceiveTextField>
    with DebounceMixin {
  AsyncResult<Amount>? _result;

  @override
  void initState() {
    super.initState();
    _call();
  }

  @override
  void didUpdateWidget(covariant _ReceiveTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.amount == widget.amount) return;

    _call();
  }

  void _call() {
    final calculateEquivalent = widget.calculateEquivalent;

    if (calculateEquivalent == null) return;

    debounce(() {
      if (widget.amount.decimal < widget.minAmount) return;

      setState(() {
        _result = calculateEquivalent(widget.amount);
      });
    });
  }

  @override
  Widget build(BuildContext context) =>
      widget.amount.decimal < widget.minAmount ||
              widget.calculateEquivalent == null
          ? const SizedBox.shrink()
          : Column(
              children: [
                SizedBox(height: 16.h),
                FutureBuilder(
                  future: _result,
                  builder: (context, snapshot) {
                    final label = context.l10n.youReceiveTitle;

                    if (snapshot.connectionState != ConnectionState.done) {
                      return RampTextField(
                        label: label,
                        controller: null,
                        currency: widget.receiveCurrency,
                      );
                    }

                    final data = snapshot.data;

                    return data == null
                        ? const SizedBox.shrink()
                        : data.fold(
                            (_) => const SizedBox.shrink(),
                            (data) => RampTextField(
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
                ),
              ],
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

  final _empty = (
    ourFee: null,
    partnerFee: null,
    totalFee: null,
    extraFee: null,
  );

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
      if (widget.amount.decimal < widget.minAmount) return;

      setState(() {
        _result = widget.feeCalculator?.call(widget.amount);
      });
    });
  }

  Widget _buildFeeRows(RampFees? rampFees) => Column(
        children: [
          if (rampFees?.ourFee case final ourFee?)
            _InfoRow(
              title: context.l10n.ourFeeTitle,
              value: ourFee,
              isLoading: rampFees == null,
            ),
          if (rampFees?.partnerFee case final partnerFee)
            _InfoRow(
              title: context.l10n.partnerFeeTitle,
              value: partnerFee ?? '-',
              isLoading: rampFees == null,
            ),
          if (rampFees?.totalFee case final totalFee)
            _InfoRow(
              title: context.l10n.totalFeesTitle,
              value: totalFee?.let(
                    (value) => value.format(
                      context.locale,
                      maxDecimals: 2,
                    ),
                  ) ??
                  '-',
              isLoading: rampFees == null,
            ),
          if (rampFees?.extraFee case final extraFee?)
            _InfoRow(
              title: context.l10n.additionalFeesTitle,
              value: extraFee.let(
                    (value) => value.format(
                      context.locale,
                      maxDecimals: 2,
                    ),
                  ) ??
                  '-',
              isLoading: rampFees == null,
            ),
        ],
      );

  @override
  Widget build(BuildContext context) =>
      widget.exchangeRate == null && widget.feeCalculator == null
          ? const SizedBox.shrink()
          : _RampContainer(
              content: Column(
                children: [
                  if (widget.exchangeRate case final exchangeRate?)
                    _InfoRow(
                      title: context.l10n.exchangeRateTitle,
                      value: exchangeRate,
                    ),
                  if (widget.feeCalculator != null)
                    FutureBuilder(
                      future: _result,
                      builder: (context, snapshot) {
                        if (widget.amount.decimal < widget.minAmount) {
                          return _buildFeeRows(_empty);
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return _buildFeeRows(null);
                        }

                        final data = snapshot.data;

                        return data == null || snapshot.hasError
                            ? const SizedBox.shrink()
                            : data.fold(
                                (_) => const SizedBox.shrink(),
                                _buildFeeRows,
                              );
                      },
                    ),
                ],
              ),
            );
}

class _RampContainer extends StatelessWidget {
  const _RampContainer({
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
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
    this.isLoading = false,
  });

  final String title;
  final String? value;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (isLoading)
              LoaderAnimation(
                height: 18.h,
                width: 95.w,
              )
            else
              Text(
                value ?? '-',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff999999),
                ),
              ),
          ],
        ),
      );
}
