import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/currency.dart';
import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../data/on_ramp_order_service.dart';
import '../../../models/ramp_partner.dart';
import '../../../scalex/data/scalex_repository.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../services/off_ramp_order_service.dart';
import '../../models/profile_data.dart';
import '../../models/ramp_type.dart';
import '../../screens/ramp_amount_screen.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchScalexRamp({
    required String address,
    required ProfileData profile,
    required RampType type,
  }) async {
    final rateAndFee = await _fetchRateAndFee();

    if (rateAndFee == null) {
      showCpErrorSnackbar(
        this,
        message: l10n.tryAgainLater,
      );

      return;
    }

    Amount? amount;

    await router.push(
      RampAmountScreen.route(
        onSubmitted: (value) {
          router.pop();
          amount = value;
        },
        minAmount: Decimal.fromInt(6),
        currency: Currency.usdc,
        calculateEquivalent: (amount) => Future.delayed(
          Duration.zero,
          () => Either.right(
            amount.calculateTotalFee(
              exchangeRate: rateAndFee.offRampRate,
              offRampFee: rateAndFee.offRampFeePercentage,
            ),
          ),
        ),
        type: RampType.offRamp,
      ),
    );

    final submittedAmount = amount;
    if (submittedAmount is! CryptoAmount) return;

    final link = await _generateRampLink(
      address: address,
      profile: profile,
      type: type,
      amount: submittedAmount.decimal.toDouble(),
    );

    if (link == null) {
      showCpErrorSnackbar(
        this,
        message: l10n.tryAgainLater,
      );

      return;
    }

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      controller.addJavaScriptHandler(
        handlerName: 'scalex',
        callback: (args) async {
          if (orderWasCreated) return;

          if (type == RampType.onRamp) {
            if (args.firstOrNull
                case <String, dynamic>{
                  'reference': final String reference,
                  'to_amount': final num toAmount,
                }) {
              final decimal = Decimal.parse(toAmount.toString());
              final amount =
                  Amount.fromDecimal(value: decimal, currency: Currency.usdc)
                      as CryptoAmount;

              final order =
                  await sl<CryptopleaseClient>().fetchScalexTransaction(
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
                    router.replace(OnRampOrderScreen.route(orderId: value));
                }
              });
              orderWasCreated = true;
            }
          }

          if (type == RampType.offRamp) {
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
                    router.replace(OffRampOrderScreen.route(orderId: value));
                }
              });
              orderWasCreated = true;
            }
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

    await router.push(
      WebViewScreen.route(
        url: Uri.parse(link),
        onLoaded: handleLoaded,
      ),
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
  FiatAmount calculateTotalFee({
    required double exchangeRate,
    required double offRampFee,
  }) {
    final double inputAmount = decimal.toDouble();
    final double totalFeeInUsdc = (inputAmount * offRampFee / 100) + 0.5;

    final double netAmountInFiat =
        (inputAmount - totalFeeInUsdc) * exchangeRate;

    return FiatAmount(
      value:
          Currency.ngn.decimalToInt(Decimal.parse(netAmountInFiat.toString())),
      fiatCurrency: Currency.ngn,
    );
  }
}
