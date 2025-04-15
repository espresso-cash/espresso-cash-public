import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/markdown_text.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/services/convert_to_usd.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../fees/models/fee_type.dart';
import '../../fees/widgets/fee_label.dart';
import '../widgets/extensions.dart';
import 'olp_screen.dart';

class OLPConfirmationScreen extends StatefulWidget {
  const OLPConfirmationScreen({super.key, required this.tokenAmount});

  static void push(BuildContext context, {required CryptoAmount tokenAmount}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (context) => OLPConfirmationScreen(tokenAmount: tokenAmount)),
      );

  final CryptoAmount tokenAmount;

  @override
  State<OLPConfirmationScreen> createState() => _OLPConfirmationScreenState();
}

class _OLPConfirmationScreenState extends State<OLPConfirmationScreen> {
  Future<void> _handleSubmit() async {
    final id = await context.createOLP(amount: widget.tokenAmount);
    if (!mounted) return;

    OLPScreen.open(context, id: id);
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
    child: Scaffold(
      appBar: CpAppBar(
        title: Text(
          context.l10n.sendMoney.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        leading: const CpBackButton(),
      ),
      body: CpContentPadding(child: _TokenCreateLinkContent(amount: widget.tokenAmount)),
      bottomNavigationBar: SafeArea(
        child: CpBottomButton(onPressed: _handleSubmit, text: context.l10n.create),
      ),
    ),
  );
}

class _TokenCreateLinkContent extends StatelessWidget {
  const _TokenCreateLinkContent({required this.amount});

  final Amount amount;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SizedBox(height: 20),
      Center(child: EcMarkdownText(text: context.l10n.reviewPayment.toUpperCase())),
      const SizedBox(height: 30),
      _InformationView(amount: amount),
      const Spacer(),
    ],
  );
}

class _InformationView extends StatelessWidget {
  const _InformationView({required this.amount});

  final Amount amount;

  @override
  Widget build(BuildContext context) {
    final fiatAmount = sl<ConvertToUsd>().call(amount);

    final locale = DeviceLocale.localeOf(context);
    final formattedAmount = amount.format(locale, maxDecimals: amount.currency.decimals);
    final formattedFiatAmount = fiatAmount.formatMinimum(locale);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 50),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: CpColors.blackGreyColor,
        borderRadius: BorderRadius.all(Radius.circular(31)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: FittedBox(
              child: Text(
                formattedAmount,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (formattedFiatAmount != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    context.l10n.fiatEquivalent,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  formattedFiatAmount,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    color: CpColors.greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 12),
          const FeeLabel(
            type: FeeType.link(),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            keyTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            valueTextStyle: TextStyle(
              fontSize: 16,
              color: CpColors.greyColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n.sendExplanation,
            style: const TextStyle(
              fontSize: 14.5,
              color: CpColors.greyColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

extension on Amount? {
  String? formatMinimum(Locale locale) {
    final amount = this;
    String? formattedAmount = amount?.format(locale);

    if (amount != null && amount < _minimumAmount) {
      final formattedMinimum = _minimumAmount.format(locale);
      formattedAmount = '< $formattedMinimum';
    }

    return formattedAmount;
  }
}

const _minimumAmount = Amount.fiat(value: 1, fiatCurrency: Currency.usd);
