import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';

import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../kyc_sharing/services/kyc_service.dart';
import '../../../../kyc_sharing/widgets/kyc_flow.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../models/profile_data.dart';
import '../../../models/ramp_type.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../screens/ramp_amount_screen.dart';
import '../../../services/on_ramp_order_service.dart';
import '../data/scalex_repository.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchKycScalexOnRamp({
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

    final kycPassed = await openKycFlow();

    if (!kycPassed) return;
    final service = sl<KycSharingService>();

    final orderId = await service.createOrder(
      cryptoAmount: equivalentAmount.value.toString(),
      cryptoCurrency: equivalentAmount.cryptoCurrency.name,
      partnerPK: partnerAuthPk,
    );

    const partnerBank = 'Partner Bank';
    const partnerAccountNumber = '1234567';

    await sl<OnRampOrderService>()
        .createForManualTransfer(
      orderId: orderId,
      receiveAmount: equivalentAmount,
      partner: RampPartner.scalex,
      bankAccount: partnerAccountNumber,
      bankName: partnerBank,
      transferAmount: submittedAmount as FiatAmount,
      transferExpiryDate: DateTime.now().add(const Duration(minutes: 30)),
      submittedAmount: equivalentAmount,
      countryCode: profile.country.code,
    )
        .then((order) {
      switch (order) {
        case Left<Exception, String>():
          break;
        case Right<Exception, String>(:final value):
          OnRampOrderScreen.push(this, id: value);
      }
    });
  }

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
