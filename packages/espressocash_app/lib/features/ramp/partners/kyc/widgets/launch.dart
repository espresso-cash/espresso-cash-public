import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../kyc_sharing/services/kyc_service.dart';
import '../../../../kyc_sharing/utils/kyc_utils.dart';
import '../../../../kyc_sharing/widgets/kyc_flow.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../screens/ramp_amount_screen.dart';
import '../../scalex/data/scalex_repository.dart';
import '../services/brij_off_ramp_order_service.dart';
import '../services/brij_on_ramp_order_service.dart';

typedef PreOrderData = ({String? preOrderId, Amount? preAmount});

extension BuildContextExt on BuildContext {
  Future<void> launchKycOnRamp({PreOrderData? preOrder}) async {
    final kycStatus = sl<KycSharingService>().value?.kycStatus;

    if (preOrder?.preOrderId == null &&
        kycStatus != ValidationStatus.approved) {
      final data = await _createOnRampPreOrder();

      preOrder = data;

      if (data?.preAmount == null) return;
    }

    final kycPassed = await openKycFlow();

    if (!kycPassed) return;

    final rateAndFee = await _fetchRateAndFee();

    if (rateAndFee == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    Amount? amount;

    final double rampRate = rateAndFee.onRampRate ?? 0;
    final double rampFeePercentage = rateAndFee.onRampFeePercentage ?? 0;
    final double fixedFee = rateAndFee.fixedOnRampFee ?? 0;

    const partner = RampPartner.brij;

    final minAmountNGN =
        partner.minimumAmountInDecimal * Decimal.parse(rampRate.toString());

    await RampAmountScreen.push(
      this,
      partner: partner,
      initialAmount: preOrder?.preAmount,
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

    final orderId = await runWithLoader<String?>(
      this,
      () => sl<BrijOnRampOrderService>()
          .createOrUpdate(
            preOrderId: preOrder?.preOrderId,
            receiveAmount: equivalentAmount,
            submittedAmount: submittedAmount as FiatAmount,
            partnerAuthPk: partner.partnerPK ?? '',
          )
          .then(
            (order) => order.fold(
              (error) => null,
              (id) => id,
            ),
          ),
    );

    if (orderId != null) {
      OnRampOrderScreen.push(this, id: orderId);
    } else {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);
    }
  }

  Future<void> launchKycOffRamp({PreOrderData? preOrder}) async {
    final kycStatus = sl<KycSharingService>().value?.kycStatus;

    if (preOrder?.preOrderId == null &&
        kycStatus != ValidationStatus.approved) {
      final data = await _createOffRampPreOrder();

      preOrder = data;

      if (data?.preAmount == null) return;
    }

    final kycPassed = await openKycFlow();

    if (!kycPassed) return;

    final rateAndFee = await _fetchRateAndFee();

    if (rateAndFee == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    Amount? amount;

    final double rampRate = rateAndFee.offRampRate;
    final double rampFeePercentage = rateAndFee.offRampFeePercentage;
    final double fixedFee = rateAndFee.fixedOffRampFee;

    const partner = RampPartner.brij;

    await RampAmountScreen.push(
      this,
      partner: partner,
      initialAmount: preOrder?.preAmount,
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

    final equivalentAmount = submittedAmount.calculateOffRampReceiveAmount(
      exchangeRate: rampRate,
      percentageFee: rampFeePercentage,
      fixedFee: fixedFee,
    );

    final orderId = await runWithLoader<String?>(
      this,
      () => sl<BrijOffRampOrderService>()
          .createOrUpdate(
            preOrderId: preOrder?.preOrderId,
            receiveAmount: equivalentAmount,
            submittedAmount: submittedAmount,
            partnerAuthPk: partner.partnerPK ?? '',
          )
          .then(
            (order) => order.fold(
              (error) => null,
              (id) => id,
            ),
          ),
    );

    if (orderId != null) {
      OffRampOrderScreen.push(this, id: orderId);
    } else {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);
    }
  }

  Future<PreOrderData?> _createOnRampPreOrder() async {
    final rateAndFee = await _fetchRateAndFee();

    if (rateAndFee == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return null;
    }

    final double rampRate = rateAndFee.onRampRate ?? 0;
    final double rampFeePercentage = rateAndFee.onRampFeePercentage ?? 0;
    final double fixedFee = rateAndFee.fixedOnRampFee ?? 0;

    const partner = RampPartner.brij;

    final minAmountNGN =
        partner.minimumAmountInDecimal * Decimal.parse(rampRate.toString());

    Amount? preAmount;
    String? preOrderId;

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (Amount? value) async {
        try {
          preAmount = value;

          final submittedPreAmount = preAmount;
          if (submittedPreAmount == null) return;

          final preEquivalentAmount =
              submittedPreAmount.calculateOnRampReceiveAmount(
            exchangeRate: rampRate,
            percentageFee: rampFeePercentage,
            fixedFee: fixedFee,
          );

          preOrderId = await runWithLoader<String?>(
            this,
            () => sl<BrijOnRampOrderService>()
                .createPreOrder(
                  submittedAmount: submittedPreAmount as FiatAmount,
                  receiveAmount: preEquivalentAmount,
                )
                .then(
                  (order) => order.fold(
                    (error) => null,
                    (id) => id,
                  ),
                ),
          );
        } finally {
          Navigator.pop(this);
        }
      },
      minAmount: minAmountNGN,
      currency: Currency.ngn,
      receiveCurrency: Currency.usdc,
      type: RampType.onRamp,
    );

    return (preOrderId: preOrderId, preAmount: preAmount);
  }

  Future<PreOrderData?> _createOffRampPreOrder() async {
    final rateAndFee = await _fetchRateAndFee();

    if (rateAndFee == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return null;
    }

    final double rampRate = rateAndFee.offRampRate;
    final double rampFeePercentage = rateAndFee.offRampFeePercentage;
    final double fixedFee = rateAndFee.fixedOffRampFee;

    const partner = RampPartner.brij;

    Amount? preAmount;
    String? preOrderId;

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (Amount? value) async {
        try {
          preAmount = value;

          final submittedPreAmount = preAmount;
          if (submittedPreAmount == null) return;

          final equivalentAmount =
              submittedPreAmount.calculateOffRampReceiveAmount(
            exchangeRate: rampRate,
            percentageFee: rampFeePercentage,
            fixedFee: fixedFee,
          );

          preOrderId = await runWithLoader<String?>(
            this,
            () => sl<BrijOffRampOrderService>()
                .createPreOrder(
                  receiveAmount: equivalentAmount,
                  submittedAmount: submittedPreAmount as CryptoAmount,
                )
                .then(
                  (order) => order.fold(
                    (error) => null,
                    (id) => id,
                  ),
                ),
          );
        } finally {
          Navigator.pop(this);
        }
      },
      minAmount: partner.minimumAmountInDecimal,
      currency: Currency.usdc,
      receiveCurrency: Currency.ngn,
      type: RampType.offRamp,
    );

    return (preOrderId: preOrderId, preAmount: preAmount);
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
}
