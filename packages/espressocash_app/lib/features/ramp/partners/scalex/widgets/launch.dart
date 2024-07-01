import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../di.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/theme.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../models/profile_data.dart';
import '../../../models/ramp_type.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../screens/ramp_amount_screen.dart';
import '../../../services/off_ramp_order_service.dart';
import '../../../services/on_ramp_order_service.dart';
import '../data/scalex_repository.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchScalexOnRamp({
    required String address,
    required ProfileData profile,
  }) async {
    final rateAndFee = await _fetchRateAndFee();

    if (rateAndFee == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    Amount? amount;

    final double rampRate = rateAndFee.onRampRate ?? 0;
    final double rampFeePercentage = rateAndFee.onRampFeePercentage ?? 0;
    final double fixedFee = rateAndFee.fixedOnRampFee ?? 0;

    const partner = RampPartner.scalex;

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (Amount? value) {
        Navigator.pop(this);
        amount = value;
      },
      minAmount: partner.minimumAmountInDecimal,
      currency: Currency.usdc,
      calculateEquivalent: (Amount amount) async => Either.right(
        (
          amount: amount.calculateOnRampFee(
            exchangeRate: rampRate,
          ),
          rate: '1 USDC = $rampRate NGN'
        ),
      ),
      partnerFeeLabel: 'Partner Fee: ${rampFeePercentage * 100}% + \$$fixedFee',
      type: RampType.onRamp,
    );

    final submittedAmount = amount;

    if (submittedAmount is! CryptoAmount) return;

    final link = await _generateRampLink(
      address: address,
      profile: profile,
      type: RampType.onRamp,
      amount: submittedAmount.decimal.toDouble() * rampRate,
    );

    if (link == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      await controller.evaluateJavascript(source: await _loadCustomStyle());

      controller.addJavaScriptHandler(
        handlerName: 'scalex',
        callback: (args) async {
          if (orderWasCreated) return;

          if (args.firstOrNull
              case <String, dynamic>{
                'reference': final String reference,
                'to_amount': final num toAmount,
              }) {
            final decimal = Decimal.parse(toAmount.toString());
            final amount =
                Amount.fromDecimal(value: decimal, currency: Currency.usdc)
                    as CryptoAmount;

            final order = await sl<EspressoCashClient>().fetchScalexTransaction(
              OrderStatusScalexRequestDto(referenceId: reference),
            );

            final details = order.onRampDetails;

            if (details == null) return;

            final transferAmount = Amount.fromDecimal(
              value: Decimal.parse(details.fromAmount.toString()),
              currency: currencyFromString(details.currency.toUpperCase()),
            ) as FiatAmount;

            await sl<OnRampOrderService>()
                .createForManualTransfer(
              orderId: reference,
              receiveAmount: amount,
              partner: RampPartner.scalex,
              bankAccount: details.bankAccount,
              bankName: details.bankName,
              transferAmount: transferAmount,
              transferExpiryDate:
                  DateTime.now().add(const Duration(minutes: 30)),
              submittedAmount: submittedAmount,
            )
                .then((order) {
              switch (order) {
                case Left<Exception, String>():
                  break;
                case Right<Exception, String>(:final value):
                  OnRampOrderScreen.pushReplacement(this, id: value);
              }
            });
            orderWasCreated = true;
          }
        },
      );
      await controller.evaluateJavascript(
        source: '''
window.addEventListener("message", (event) => {
  window.flutter_inappwebview.callHandler('scalex', event.data);
}, false);
''',
      );
    }

    await WebViewScreen.push(
      this,
      url: Uri.parse(link),
      onLoaded: handleLoaded,
      title: l10n.ramp_titleCashIn.toUpperCase(),
      theme: const CpThemeData.black(),
    );
  }

  Future<void> launchScalexOffRamp({
    required String address,
    required ProfileData profile,
  }) async {
    final rateAndFee = await _fetchRateAndFee();

    if (rateAndFee == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    Amount? amount;

    const partner = RampPartner.scalex;

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (value) {
        Navigator.pop(this);
        amount = value;
      },
      minAmount: partner.minimumAmountInDecimal,
      currency: Currency.usdc,
      calculateEquivalent: (amount) async => Either.right(
        (
          amount: amount.calculateOffRampFee(
            exchangeRate: rateAndFee.offRampRate,
            percentageFee: rateAndFee.offRampFeePercentage,
            fixedFee: rateAndFee.fixedOffRampFee,
          ),
          rate: '1 USDC = ${rateAndFee.offRampRate} NGN'
        ),
      ),
      partnerFeeLabel:
          'Partner Fee: ${rateAndFee.offRampFeePercentage * 100}% + \$${rateAndFee.fixedOffRampFee} (included)',
      type: RampType.offRamp,
    );

    final submittedAmount = amount;

    if (submittedAmount is! CryptoAmount) return;

    final link = await _generateRampLink(
      address: address,
      profile: profile,
      type: RampType.offRamp,
      amount: submittedAmount.decimal.toDouble(),
    );

    if (link == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      await controller.evaluateJavascript(source: await _loadCustomStyle());

      controller.addJavaScriptHandler(
        handlerName: 'scalex',
        callback: (args) async {
          if (orderWasCreated) return;

          if (args.firstOrNull
              case <String, dynamic>{
                'reference': final String reference,
                'from_amount': final num fromAmount,
                'to_amount': final num toAmount,
                // ignore: avoid-missing-interpolation, similar names
                'address': final String address,
              }) {
            final decimal = Decimal.parse(fromAmount.toString());
            final amount =
                Amount.fromDecimal(value: decimal, currency: Currency.usdc)
                    as CryptoAmount;

            final receiveAmount = Amount.fromDecimal(
              value: Decimal.parse(toAmount.toString()),
              currency: Currency.ngn,
            ) as FiatAmount;

            await sl<OffRampOrderService>()
                .create(
              partnerOrderId: reference,
              amount: amount,
              partner: RampPartner.scalex,
              receiveAmount: receiveAmount,
              depositAddress: address,
            )
                .then((order) {
              switch (order) {
                case Left<Exception, String>():
                  break;
                case Right<Exception, String>(:final value):
                  OffRampOrderScreen.pushReplacement(this, id: value);
              }
            });
            orderWasCreated = true;
          }
        },
      );
      await controller.evaluateJavascript(
        source: '''
window.addEventListener("message", (event) => {
  window.flutter_inappwebview.callHandler('scalex', event.data);
}, false);
''',
      );
    }

    await WebViewScreen.push(
      this,
      url: Uri.parse(link),
      onLoaded: handleLoaded,
      title: l10n.ramp_titleCashOut,
      theme: const CpThemeData.black(),
    );
  }

  Future<String?> _generateRampLink({
    required String address,
    required ProfileData profile,
    required RampType type,
    required double amount,
  }) =>
      runWithLoader<String?>(this, () async {
        try {
          final client = sl<ScalexRepository>();

          return await client.generateLink(
            type: type == RampType.onRamp ? 'onramp' : 'offramp',
            address: address,
            email: profile.email,
            amount: amount,
          );
        } on Exception {
          return null;
        }
      });

  Future<ScalexRateFeeResponseDto?> _fetchRateAndFee() =>
      runWithLoader<ScalexRateFeeResponseDto?>(this, () async {
        try {
          final client = sl<ScalexRepository>();

          return await client.fetchRateAndFee();
        } on Exception {
          return null;
        }
      });
}

extension on Amount {
  FiatAmount calculateOffRampFee({
    required double exchangeRate,
    required double percentageFee,
    required double fixedFee,
  }) {
    final double inputAmount = decimal.toDouble();
    final double totalFeeInUsdc = (inputAmount * percentageFee) + fixedFee;

    final double netAmountInFiat =
        (inputAmount - totalFeeInUsdc) * exchangeRate;

    return FiatAmount(
      value:
          Currency.ngn.decimalToInt(Decimal.parse(netAmountInFiat.toString())),
      fiatCurrency: Currency.ngn,
    );
  }

  FiatAmount calculateOnRampFee({
    required double exchangeRate,
  }) {
    final double inputAmount = decimal.toDouble() * exchangeRate;

    return FiatAmount(
      value: Currency.ngn.decimalToInt(Decimal.parse(inputAmount.toString())),
      fiatCurrency: Currency.ngn,
    );
  }
}

Future<String> _loadCustomStyle() async {
  final css = await rootBundle.loadString(Assets.scalex.style);

  return """
  (function() {
    var style = document.createElement('style');
    style.type = 'text/css';
    style.innerHTML = `$css`;
    document.head.appendChild(style);
  })();
""";
}
