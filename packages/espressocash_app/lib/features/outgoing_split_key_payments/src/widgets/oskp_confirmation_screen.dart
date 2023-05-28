import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/amount.dart';
import '../../../../core/conversion_rates/context_ext.dart';
import '../../../../core/currency.dart';
import '../../../../core/fee_label.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/button.dart';
import '../../../../ui/chip.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/info_widget.dart';
import '../../../../ui/theme.dart';

class OSKPConfirmationScreen extends StatelessWidget {
  const OSKPConfirmationScreen({
    super.key,
    required this.tokenAmount,
    required this.fee,
    required this.onSubmit,
  });

  final Amount tokenAmount;
  final Amount fee;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(
              context.l10n.pay.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            leading: CpBackButton(onPressed: () => context.router.pop()),
          ),
          body: CpContentPadding(
            child: _TokenCreateLinkContent(
              amount: tokenAmount,
              fee: fee,
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FeeLabel(type: FeeType.splitKey()),
                  const SizedBox(height: 21),
                  CpButton(
                    width: double.infinity,
                    onPressed: onSubmit,
                    text: context.l10n.create,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _TokenCreateLinkContent extends StatelessWidget {
  const _TokenCreateLinkContent({
    required this.amount,
    required this.fee,
  });

  final Amount amount;
  final Amount fee;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            context.l10n.youAreCreatingUniqueLink,
            style: _mediumTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _AmountView(amount: amount),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CpInfoWidget(message: Text(context.l10n.sendExplanation)),
          ),
          const Spacer(),
        ],
      );
}

const _mediumTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

class _AmountView extends StatelessWidget {
  const _AmountView({required this.amount});

  final Amount amount;

  @override
  Widget build(BuildContext context) {
    const currency = Currency.usd;
    final fiatAmount = amount.map(
      crypto: (crypto) => context.convertToFiat(
        fiatCurrency: currency,
        token: crypto.token,
        amount: crypto.value,
      ),
      fiat: identity,
    );

    final locale = DeviceLocale.localeOf(context);
    final formattedAmount = amount.format(
      locale,
      maxDecimals: currency.decimals,
    );
    final formattedFiatAmount = fiatAmount.formatMinimum(locale);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          child: Text(
            formattedAmount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 55,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 24),
          child: CpChip(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (formattedFiatAmount != null)
                  FittedBox(
                    child: Text(
                      context.l10n
                          .fiatEquivalent(formattedFiatAmount)
                          .toUpperCase(),
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

extension on Amount? {
  String? formatMinimum(Locale locale) {
    final amount = this;
    var formattedAmount = amount?.format(locale);

    if (amount != null && amount < _minimumAmount) {
      final formattedMinimum = _minimumAmount.format(locale);
      formattedAmount = '< $formattedMinimum';
    }

    return formattedAmount;
  }
}

const _minimumAmount = Amount.fiat(value: 1, fiatCurrency: Currency.usd);
