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
import '../../../../kyc_sharing/widgets/kyc_flow.dart';
import '../../../../kyc_sharing/services/kyc_service.dart';
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

    final kycPassed = await openKycFlow();

    if (!kycPassed) return;
    final service = sl<KycSharingService>();

    final orderId = await service.createOrder(
      cryptoAmount: submittedAmount.value.toString(),
      cryptoCurrency: submittedAmount.cryptoCurrency.name,
      partnerPK: partnerAuthPk,
    );

    final user = service.value.user;

    final transferAmount = Amount.fromDecimal(
      value: submittedAmount.decimal,
      currency: Currency.ngn,
    ) as FiatAmount;

    await sl<OnRampOrderService>()
        .createForManualTransfer(
      orderId: orderId,
      receiveAmount: submittedAmount,
      partner: RampPartner.scalex,
      bankAccount: user?.bankAccountNumber ?? '',
      bankName: user?.bankCode ?? '',
      transferAmount: transferAmount,
      transferExpiryDate: DateTime.now().add(const Duration(minutes: 30)),
      submittedAmount: submittedAmount,
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
