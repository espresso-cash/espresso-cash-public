import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:sealed_countries/sealed_countries.dart' as country;

import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/bottom_button.dart';
import '../../../../../ui/dialogs.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/markdown_text.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../kyc_sharing/data/kyc_repository.dart';
import '../../../../kyc_sharing/models/kyc_validation_status.dart';
import '../../../../kyc_sharing/services/kyc_service.dart';
import '../../../../kyc_sharing/services/pending_kyc_service.dart';
import '../../../../kyc_sharing/widgets/kyc_flow.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../../router/service/navigation_service.dart';
import '../../../models/profile_data.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../screens/ramp_amount_screen.dart';
import '../services/brij_fees_service.dart';
import '../services/brij_off_ramp_order_service.dart';
import '../services/brij_on_ramp_order_service.dart';
import 'terms_notice.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchBrijOnRamp({
    required RampPartner partner,
    required ProfileData profile,
  }) async {
    final isValid = await _validateKyc(profile);

    if (!isValid) return;

    const type = RampType.onRamp;

    const inputCurrency = Currency.usdc;
    final receiveCurrency = _fromCountryCode(profile.country.code);

    final rate = await _fetchRate(type, partner, receiveCurrency.symbol);

    Amount? amount;

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (Amount? value) async {
        final hasConfirmed = await _ensureAccessGranted(partner);

        if (!hasConfirmed) return;

        Navigator.pop(this);
        amount = value;
      },
      minAmount: partner.minimumAmountInDecimal,
      currency: inputCurrency,
      receiveCurrency: receiveCurrency,
      calculateEquivalent:
          (amount) => _calculateReceiveAmount(
            amount: amount,
            type: type,
            partner: partner,
            currency: receiveCurrency,
          ),
      calculateFee:
          (amount) => _calculateFees(
            amount: amount,
            type: type,
            partner: partner,
            currency: receiveCurrency.symbol,
          ),
      exchangeRate: '1 USDC = $rate ${receiveCurrency.symbol}',
      type: type,
    );

    final submittedAmount = amount;

    if (submittedAmount == null) return;

    final equivalentAmount =
        // ignore: avoid-type-casts, controlled type
        await runWithLoader<Amount>(
              this,
              () => sl<BrijFeesService>()
                  .fetchFees(
                    amount: submittedAmount,
                    type: type,
                    partnerPK: partner.partnerPK ?? '',
                    walletPK: walletAuthPk,
                    fiatCurrency: profile.country.code,
                  )
                  .then((fees) => fees.receiveAmount),
            )
            as FiatAmount;

    final orderId = await runWithLoader<String?>(
      this,
      () => sl<BrijOnRampOrderService>()
          .create(
            // ignore: avoid-type-casts, controlled type
            receiveAmount: submittedAmount as CryptoAmount,
            submittedAmount: equivalentAmount,
            partner: partner,
            country: profile.country.code,
          )
          .then((order) => order.fold((error) => null, (id) => id)),
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
    final isValid = await _validateKyc(profile);

    if (!isValid) return;

    const type = RampType.offRamp;

    const inputCurrency = Currency.usdc;
    final receiveCurrency = _fromCountryCode(profile.country.code);

    final rate = await _fetchRate(type, partner, receiveCurrency.symbol);

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
      currency: inputCurrency,
      receiveCurrency: receiveCurrency,
      calculateEquivalent:
          (amount) => _calculateReceiveAmount(
            amount: amount,
            type: type,
            partner: partner,
            currency: receiveCurrency,
          ),
      exchangeRate: '1 USDC = $rate ${receiveCurrency.symbol}',
      calculateFee:
          (amount) => _calculateFees(
            amount: amount,
            type: type,
            partner: partner,
            currency: receiveCurrency.symbol,
          ),
      type: type,
    );

    final submittedAmount = amount;

    if (submittedAmount is! CryptoAmount) return;

    final equivalentAmount =
        // ignore: avoid-type-casts, controlled type
        await runWithLoader<Amount>(
              this,
              () => sl<BrijFeesService>()
                  .fetchFees(
                    amount: submittedAmount,
                    type: type,
                    partnerPK: partner.partnerPK ?? '',
                    walletPK: walletAuthPk,
                    fiatCurrency: profile.country.code,
                  )
                  .then((fees) => fees.receiveAmount),
            )
            as FiatAmount;

    final orderId = await runWithLoader<String?>(
      this,
      () => sl<BrijOffRampOrderService>()
          .create(
            receiveAmount: equivalentAmount,
            submittedAmount: submittedAmount,
            partner: partner,
            country: profile.country.code,
          )
          .then((order) => order.fold((error) => null, (id) => id)),
    );

    if (orderId != null) {
      OffRampOrderScreen.push(this, id: orderId);
    } else {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);
    }
  }

  Future<bool> _validateKyc(ProfileData profile) async {
    final kycService = sl<KycSharingService>();

    await runWithLoader(this, () => kycService.initialized);

    final user = kycService.value;

    if (user == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return false;
    }

    final kycStatus = await runWithLoader(
      this,
      () => sl<PendingKycService>().fetchKycStatus(country: profile.country.code),
    );

    if (kycStatus == KycValidationStatus.pending) {
      _showPendingKycDialog();

      return false;
    }

    return runWithLoader(this, () => openKycFlow(countryCode: profile.country.code));
  }

  Future<double> _fetchRate(RampType type, RampPartner partner, String currency) =>
      runWithLoader<double>(
        this,
        () => sl<BrijFeesService>().fetchRate(
          partnerPK: partner.partnerPK ?? '',
          walletPK: walletAuthPk,
          fiatCurrency: currency,
          type: type,
        ),
      );

  Future<Either<Exception, Amount>> _calculateReceiveAmount({
    required Amount amount,
    required RampType type,
    required RampPartner partner,
    required Currency currency,
  }) async {
    final fees = await sl<BrijFeesService>().fetchFees(
      partnerPK: partner.partnerPK ?? '',
      walletPK: walletAuthPk,
      fiatCurrency: currency.symbol,
      amount: amount,
      type: type,
    );

    final receiveAmount = Amount(value: fees.receiveAmount.value, currency: currency);

    return Either.right(receiveAmount);
  }

  Future<Either<Exception, RampFees>> _calculateFees({
    required Amount amount,
    required RampType type,
    required RampPartner partner,
    required String currency,
  }) async {
    final fees = await sl<BrijFeesService>().fetchFees(
      partnerPK: partner.partnerPK ?? '',
      walletPK: walletAuthPk,
      fiatCurrency: currency,
      amount: amount,
      type: type,
    );

    return Either.right((ourFee: null, partnerFee: null, extraFee: null, totalFee: fees.totalFee));
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
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
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

    final hasGrantedAccess = await sl<KycSharingService>().hasGrantedAccess(partnerPK);

    if (hasGrantedAccess) return true;

    final (:termsUrl, :policyUrl) = await sl<KycSharingService>().fetchPartnerTermsAndPolicy(
      partnerPK,
    );

    return showTermsAndPolicyDialog(this, termsUrl: termsUrl, privacyUrl: policyUrl);
  }
}

FiatCurrency _fromCountryCode(String code) {
  final currency = country.WorldCountry.fromCodeShort(code).currencies?.firstOrNull;

  return currency.toFiatCurrency.copyWith(countryCode: code);
}
