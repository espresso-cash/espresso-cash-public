import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/info_icon.dart';
import 'package:cryptoplease/app/ui/app_bar.dart';
import 'package:cryptoplease/app/ui/button.dart';
import 'package:cryptoplease/app/ui/chip.dart';
import 'package:cryptoplease/app/ui/content_padding.dart';
import 'package:cryptoplease/app/ui/info_widget.dart';
import 'package:cryptoplease/app/ui/theme.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/conversion_rates/presentation/conversion_rates.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

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
            leading: BackButton(onPressed: () => context.router.pop()),
          ),
          body: CpContentPadding(
            child: _TokenCreateLinkContent(
              amount: tokenAmount,
              fee: fee,
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24.0),
            child: CpButton(
              onPressed: onSubmit,
              text: context.l10n.create,
            ),
          ),
        ),
      );
}

class _TokenCreateLinkContent extends StatelessWidget {
  const _TokenCreateLinkContent({
    Key? key,
    required this.amount,
    required this.fee,
  }) : super(key: key);

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
          _AmountFeeView(
            amount: amount,
            fee: fee,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CpInfoWidget(
              icon: const InfoIcon(),
              message: Text(context.l10n.sendExplanation),
            ),
          ),
          const Spacer(),
        ],
      );
}

const _mediumTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

class _AmountFeeView extends StatelessWidget {
  const _AmountFeeView({
    Key? key,
    required this.amount,
    required this.fee,
  }) : super(key: key);

  final Amount amount;
  final Amount fee;

  @override
  Widget build(BuildContext context) {
    final fiatAmount = amount.map(
      crypto: (crypto) => context.convertToFiat(
        fiatCurrency: Currency.usd,
        token: crypto.token,
        amount: crypto.value,
      ),
      fiat: identity,
    );

    final fiatFee = fee.map(
      crypto: (crypto) => context.convertToFiat(
        fiatCurrency: Currency.usd,
        token: crypto.token,
        amount: crypto.value,
      ),
      fiat: identity,
    );

    final locale = DeviceLocale.localeOf(context);
    final formattedAmount = amount.format(locale);
    final formattedFiatAmount = fiatAmount.formatMinimum(locale);
    final formattedFiatFee = fiatFee.formatMinimum(locale);

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
                if (formattedFiatFee != null)
                  Text(
                    context.l10n.feeAmount(formattedFiatFee),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
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

const _minimumAmount = Amount.fiat(value: 1, currency: Currency.usd);
