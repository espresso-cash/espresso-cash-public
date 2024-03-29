import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

import '../../../../../di.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routing.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/theme.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../data/on_ramp_order_service.dart';
import '../../../models/ramp_partner.dart';
import '../../../models/ramp_type.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../screens/ramp_amount_screen.dart';
import '../../../services/off_ramp_order_service.dart';
import '../../../src/models/profile_data.dart';
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

    await RampAmountRoute(
      (
        partner: RampPartner.scalex,
        onSubmitted: (Amount? value) {
          pop();
          amount = value;
        },
        minAmount: Decimal.fromInt(10),
        currency: Currency.usdc,
        calculateEquivalent: (Amount amount) => (
              amount: amount.calculateOnRampFee(
                exchangeRate: rampRate,
              ),
              rate: '1 USDC = $rampRate NGN'
            ),
        partnerFeeLabel:
            'Partner Fee: ${rampFeePercentage * 100}% + \$$fixedFee',
        calculateFee: null,
        type: RampType.onRamp,
      ),
    ).push<void>(this);

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
            )
                .then((order) {
              switch (order) {
                case Left<Exception, String>():
                  break;
                case Right<Exception, String>(:final value):
                  OnRampOrderRoute(value).pushReplacement(this);
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

    await WebViewRoute(
      (
        url: Uri.parse(link),
        onLoaded: handleLoaded,
        title: l10n.ramp_titleCashIn,
        theme: const CpThemeData.black(),
      ),
    ).push<void>(this);
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

    await RampAmountRoute(
      (
        partner: RampPartner.scalex,
        onSubmitted: (value) {
          pop();
          amount = value;
        },
        minAmount: Decimal.fromInt(10),
        currency: Currency.usdc,
        calculateEquivalent: (amount) => (
              amount: amount.calculateOffRampFee(
                exchangeRate: rateAndFee.offRampRate,
                percentageFee: rateAndFee.offRampFeePercentage,
                fixedFee: rateAndFee.fixedOffRampFee,
              ),
              rate: '1 USDC = ${rateAndFee.offRampRate} NGN'
            ),
        partnerFeeLabel:
            'Partner Fee: ${rateAndFee.offRampFeePercentage * 100}% + \$${rateAndFee.fixedOffRampFee} (included)',
        calculateFee: null,
        type: RampType.offRamp,
      ),
    ).push<void>(this);

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
                  OffRampOrderRoute(value).pushReplacement(this);
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

    await WebViewRoute(
      (
        url: Uri.parse(link),
        onLoaded: handleLoaded,
        title: l10n.ramp_titleCashOut,
        theme: const CpThemeData.black(),
      ),
    ).push<void>(this);
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
