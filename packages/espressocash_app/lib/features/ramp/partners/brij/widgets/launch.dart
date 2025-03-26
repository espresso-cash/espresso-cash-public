import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/bottom_button.dart';
import '../../../../../ui/dialogs.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/markdown_text.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../kyc_sharing/services/kyc_service.dart';
import '../../../../kyc_sharing/utils/kyc_utils.dart';
import '../../../../kyc_sharing/widgets/kyc_flow.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../../router/service/navigation_service.dart';
import '../../../models/profile_data.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../screens/ramp_amount_screen.dart';
import '../services/brij_off_ramp_order_service.dart';
import '../services/brij_on_ramp_order_service.dart';
import '../services/brij_scalex_fees_service.dart';
import 'terms_notice.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchBrijOnRamp({
    required RampPartner partner,
    required ProfileData profile,
  }) async {
    final kycService = sl<KycSharingService>();

    await runWithLoader(this, () async => kycService.initialized);

    final user = kycService.value;

    if (user == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    if (user.kycStatus == ValidationStatus.pending) {
      _showPendingKycDialog();

      return;
    }

    final kycPassed = await openKycFlow(countryCode: profile.country.code);

    if (!kycPassed) return;

    const type = RampType.onRamp;

    final rate = await _fetchRate(type);

    Amount? amount;

    final minAmountNGN =
        partner.minimumAmountInDecimal * Decimal.parse(rate.toString());

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (Amount? value) async {
        final hasConfirmed = await _ensureAccessGranted(partner);

        if (!hasConfirmed) return;

        Navigator.pop(this);
        amount = value;
      },
      minAmount: minAmountNGN,
      currency: Currency.ngn,
      receiveCurrency: Currency.usdc,
      calculateEquivalent: (amount) => _calculateReceiveAmount(
        amount: amount,
        type: type,
      ),
      calculateFee: (amount) => _calculateFees(
        amount: amount,
        type: type,
      ),
      exchangeRate: '1 USDC = $rate NGN',
      type: type,
    );

    final submittedAmount = amount;

    if (submittedAmount == null) return;

    final equivalentAmount = await runWithLoader<Amount>(
      this,
      () => sl<BrijScalexFeesService>()
          .fetchFees(
            amount: submittedAmount,
            type: type,
          )
          .then((fees) => fees.receiveAmount),
    ) as CryptoAmount;

    final orderId = await runWithLoader<String?>(
      this,
      () => sl<BrijOnRampOrderService>()
          .create(
            receiveAmount: equivalentAmount,
            submittedAmount: submittedAmount as FiatAmount,
            partner: partner,
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

  Future<void> launchBrijOffRamp({
    required RampPartner partner,
    required ProfileData profile,
  }) async {
    final kycService = sl<KycSharingService>();

    await runWithLoader(this, () async => kycService.initialized);

    final user = kycService.value;

    if (user == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    if (user.kycStatus == ValidationStatus.pending) {
      _showPendingKycDialog();

      return;
    }
    final kycPassed = await openKycFlow(countryCode: profile.country.code);

    if (!kycPassed) return;

    const type = RampType.offRamp;

    final rate = await _fetchRate(type);

    Amount? amount;

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (value) async {
        final hasConfirmed = await _ensureAccessGranted(partner);

        if (!hasConfirmed) return;

        Navigator.pop(this);
        amount = value;
      },
      minAmount: partner.minimumAmountInDecimal,
      currency: Currency.usdc,
      receiveCurrency: Currency.ngn,
      calculateEquivalent: (amount) => _calculateReceiveAmount(
        amount: amount,
        type: type,
      ),
      exchangeRate: '1 USDC = $rate NGN',
      calculateFee: (amount) => _calculateFees(
        amount: amount,
        type: type,
      ),
      type: type,
    );

    final submittedAmount = amount;

    if (submittedAmount is! CryptoAmount) return;

    final equivalentAmount = await runWithLoader<Amount>(
      this,
      () => sl<BrijScalexFeesService>()
          .fetchFees(
            amount: submittedAmount,
            type: type,
          )
          .then((fees) => fees.receiveAmount),
    ) as FiatAmount;

    final orderId = await runWithLoader<String?>(
      this,
      () => sl<BrijOffRampOrderService>()
          .create(
            receiveAmount: equivalentAmount,
            submittedAmount: submittedAmount,
            partner: partner,
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

  Future<double> _fetchRate(RampType type) => runWithLoader<double>(
        this,
        () async => sl<BrijScalexFeesService>().fetchRate(type),
      );

  Future<Either<Exception, Amount>> _calculateReceiveAmount({
    required Amount amount,
    required RampType type,
  }) async {
    final fees = await sl<BrijScalexFeesService>().fetchFees(
      amount: amount,
      type: type,
    );

    final receiveAmount = fees.receiveAmount;

    return Either.right(receiveAmount);
  }

  Future<Either<Exception, RampFees>> _calculateFees({
    required Amount amount,
    required RampType type,
  }) async {
    final fees = await sl<BrijScalexFeesService>().fetchFees(
      amount: amount,
      type: type,
    );

    return Either.right(
      (
        ourFee: null,
        partnerFee: null,
        extraFee: null,
        totalFee: fees.totalFee,
      ),
    );
  }

  void _showPendingKycDialog() {
    showCustomDialog<void>(
      this,
      title: EcMarkdownText(
        text: l10n.pendingKycDialogTitle.toUpperCase(),
        textAlign: WrapAlignment.center,
      ),
      message: Text(
        l10n.pendingKycDialogMessage,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: CpBottomButton(
        text: l10n.activityButton,
        horizontalPadding: 0,
        onPressed: () => sl<HomeNavigationService>().openActivitiesTab(this),
      ),
    );
  }

  Future<bool> _ensureAccessGranted(RampPartner partner) async {
    final partnerPK = partner.partnerPK;

    if (partnerPK == null) return false;

    final hasGrantedAccess =
        await sl<KycSharingService>().hasGrantedAccess(partnerPK);

    if (hasGrantedAccess) return true;

    final (:termsUrl, :policyUrl) =
        await sl<KycSharingService>().fetchPartnerTermsAndPolicy(partnerPK);

    return showTermsAndPolicyDialog(
      this,
      termsUrl: termsUrl,
      privacyUrl: policyUrl,
    );
  }
}
