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

    final minAmountNGN =
        partner.minimumAmountInDecimal * Decimal.parse(rampRate.toString());

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (Amount? value) {
        Navigator.pop(this);
        amount = value;
      },
      minAmount: minAmountNGN,
      currency: Currency.ngn,
      receiveCurrency: Currency.usdc,
      calculateEquivalent: (Amount amount) async => Either.right(
        amount.calculateOnRampReceiveAmount(
          exchangeRate: rampRate,
          percentageFee: rampFeePercentage,
          fixedFee: fixedFee,
        ),
      ),
      calculateFee: (amount) async {
        final fee = amount.calculateOnRampFee(
          exchangeRate: rampRate,
          percentageFee: rampFeePercentage,
          fixedFee: fixedFee,
        );

        return Either.right(
          (
            ourFee: null,
            partnerFee: '${rampFeePercentage * 100}% + \$$fixedFee',
            totalFee: fee,
            extraFee: null,
          ),
        );
      },
      exchangeRate: '1 USDC = $rampRate NGN',
      type: RampType.onRamp,
    );

    final submittedAmount = amount;

    if (submittedAmount == null) return;

    final equivalentAmount = submittedAmount.calculateOnRampReceiveAmount(
      exchangeRate: rampRate,
      percentageFee: rampFeePercentage,
      fixedFee: fixedFee,
    );

    final link = await _generateRampLink(
      address: address,
      profile: profile,
      type: RampType.onRamp,
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
              submittedAmount: equivalentAmount,
              countryCode: profile.country.code,
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

    final double rampRate = rateAndFee.offRampRate;
    final double rampFeePercentage = rateAndFee.offRampFeePercentage;
    final double fixedFee = rateAndFee.fixedOffRampFee;

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
      receiveCurrency: Currency.ngn,
      calculateEquivalent: (amount) async => Either.right(
        amount.calculateOffRampReceiveAmount(
          exchangeRate: rampRate,
          percentageFee: rampFeePercentage,
          fixedFee: fixedFee,
        ),
      ),
      exchangeRate: '1 USDC = $rampRate NGN',
      calculateFee: (amount) async {
        final fee = amount.calculateOffRampFee(
          exchangeRate: rampRate,
          percentageFee: rampFeePercentage,
          fixedFee: fixedFee,
        );

        return Either.right(
          (
            ourFee: null,
            partnerFee: '${rampFeePercentage * 100}% + \$$fixedFee',
            totalFee: fee,
            extraFee: null,
          ),
        );
      },
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
              countryCode: profile.country.code,
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
  FiatAmount calculateOffRampReceiveAmount({
    required double exchangeRate,
    required double percentageFee,
    required double fixedFee,
  }) {
    final (amountInNGN, feeInUSDC) = _calculateOffRampAmounts(
      exchangeRate: exchangeRate,
      percentageFee: percentageFee,
      fixedFee: fixedFee,
    );
    final double netAmountInNGN = amountInNGN - (feeInUSDC * exchangeRate);

    return FiatAmount(
      value:
          Currency.ngn.decimalToInt(Decimal.parse(netAmountInNGN.toString())),
      fiatCurrency: Currency.ngn,
    );
  }

  FiatAmount calculateOffRampFee({
    required double exchangeRate,
    required double percentageFee,
    required double fixedFee,
  }) {
    final (_, feeInUSDC) = _calculateOffRampAmounts(
      exchangeRate: exchangeRate,
      percentageFee: percentageFee,
      fixedFee: fixedFee,
    );
    final double feeInNGN = feeInUSDC * exchangeRate;

    return FiatAmount(
      value: Currency.ngn.decimalToInt(Decimal.parse(feeInNGN.toString())),
      fiatCurrency: Currency.ngn,
    );
  }

  (double, double) _calculateOffRampAmounts({
    required double exchangeRate,
    required double percentageFee,
    required double fixedFee,
  }) {
    final double inputAmountInUSDC = decimal.toDouble();
    final double feeInUSDC = (inputAmountInUSDC * percentageFee) + fixedFee;
    final double amountInNGN = inputAmountInUSDC * exchangeRate;

    return (amountInNGN, feeInUSDC);
  }

  CryptoAmount calculateOnRampReceiveAmount({
    required double exchangeRate,
    required double percentageFee,
    required double fixedFee,
  }) {
    final (amountInUSDC, feeInUSDC) = _calculateOnRampAmounts(
      exchangeRate: exchangeRate,
      percentageFee: percentageFee,
      fixedFee: fixedFee,
    );
    final double netAmountInUSDC = amountInUSDC - feeInUSDC;

    return CryptoAmount(
      value:
          Currency.usdc.decimalToInt(Decimal.parse(netAmountInUSDC.toString())),
      cryptoCurrency: Currency.usdc,
    );
  }

  CryptoAmount calculateOnRampFee({
    required double exchangeRate,
    required double percentageFee,
    required double fixedFee,
  }) {
    final (_, feeInUSDC) = _calculateOnRampAmounts(
      exchangeRate: exchangeRate,
      percentageFee: percentageFee,
      fixedFee: fixedFee,
    );

    return CryptoAmount(
      value: Currency.usdc.decimalToInt(Decimal.parse(feeInUSDC.toString())),
      cryptoCurrency: Currency.usdc,
    );
  }

  (double, double) _calculateOnRampAmounts({
    required double exchangeRate,
    required double percentageFee,
    required double fixedFee,
  }) {
    final double inputAmountInNGN = decimal.toDouble();
    final double amountInUSDC = inputAmountInNGN / exchangeRate;
    final double feeInUSDC = (amountInUSDC * percentageFee) + fixedFee;

    return (amountInUSDC, feeInUSDC);
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
