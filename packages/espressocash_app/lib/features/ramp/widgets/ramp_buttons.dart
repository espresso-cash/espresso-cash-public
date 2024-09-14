import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/button.dart';
import '../../../ui/icon_button.dart';
import '../../accounts/models/account.dart';
import '../../analytics/analytics_manager.dart';
import '../../country_picker/models/country.dart';
import '../../feature_flags/services/feature_flags_manager.dart';
import '../../profile/data/profile_repository.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../models/profile_data.dart';
import '../models/ramp_type.dart';
import '../partners/coinflow/widgets/launch.dart';
import '../partners/guardarian/widgets/launch.dart';
import '../partners/kado/widgets/launch.dart';
import '../partners/moneygram/widgets/launch.dart';
import '../partners/ramp_network/widgets/launch.dart';
import '../partners/scalex/widgets/launch.dart';
import '../partners/scalex/widgets/launch_kyc.dart';
import '../screens/ramp_onboarding_screen.dart';
import '../screens/ramp_partner_select_screen.dart';
import 'off_ramp_bottom_sheet.dart';

class PayOrRequestButton extends StatelessWidget {
  const PayOrRequestButton({
    super.key,
    required this.voidCallback,
    this.size = CpButtonSize.normal,
  });

  final CpButtonSize size;
  final VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          CpIconButton(
            icon: Assets.icons.dolar.svg(color: Colors.black),
            variant: CpIconButtonVariant.dark,
            size: CpIconButtonSize.large,
            onPressed: voidCallback,
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.requestOrSendPayment,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      );
}

class AddCashButton extends StatelessWidget {
  const AddCashButton({
    super.key,
    this.size = CpButtonSize.normal,
  });

  final CpButtonSize size;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CpIconButton(
            icon: Assets.icons.addAlternative.svg(color: Colors.black),
            variant: CpIconButtonVariant.dark,
            size: CpIconButtonSize.large,
            onPressed: () async {
              final data = await context.ensureProfileData(RampType.onRamp);
              if (context.mounted && data != null) {
                context.launchOnRampFlow(
                  profile: data,
                  address: sl<MyAccount>().wallet.publicKey.toBase58(),
                );
              }
            },
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.ramp_btnAddCash,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      );
}

class CashOutButton extends StatelessWidget {
  const CashOutButton({
    super.key,
    this.size = CpButtonSize.normal,
  });

  final CpButtonSize size;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CpIconButton(
            icon: Assets.icons.withdrawn.svg(color: Colors.black),
            variant: CpIconButtonVariant.dark,
            size: CpIconButtonSize.large,
            onPressed: () async {
              final data = await context.ensureProfileData(RampType.offRamp);
              if (context.mounted && data != null) {
                context.launchOffRampFlow(
                  profile: data,
                  address: sl<MyAccount>().wallet.publicKey.toBase58(),
                );
              }
            },
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.ramp_btnCashOut,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      );
}

extension RampBuildContextExt on BuildContext {
  Future<ProfileData?> ensureProfileData(RampType rampType) async {
    void handleSubmitted() {
      Navigator.pop(this);
    }

    final repository = sl<ProfileRepository>();
    Country? country = repository.country?.let(Country.findByCode);
    String email = repository.email;

    if (country != null && email.isNotEmpty) {
      return (country: country, email: email);
    }

    await RampOnboardingScreen.push(
      this,
      onConfirmed: handleSubmitted,
      rampType: rampType,
    );

    country = repository.country?.let(Country.findByCode);
    email = repository.email;

    return country != null && email.isNotEmpty
        ? (country: country, email: email)
        : null;
  }

  void launchOnRampFlow({
    required ProfileData profile,
    required String address,
  }) {
    final partners = _getOnRampPartners(profile.country.code);

    if (partners.isEmpty) {
      OffRampBottomSheet.show(this, title: l10n.ramp_btnAddCash);

      return;
    }

    final [top, ...others] = partners.unlock;

    if (others.isEmpty) {
      _launchOnRampPartner(
        top,
        profile: profile,
        address: address,
      );

      return;
    }

    RampPartnerSelectScreen.push(
      this,
      topPartner: top,
      otherPartners: others.lock,
      type: RampType.onRamp,
      onPartnerSelected: (RampPartner p) {
        Navigator.pop(this);
        _launchOnRampPartner(p, profile: profile, address: address);
      },
    );
  }

  void launchOffRampFlow({
    required ProfileData profile,
    required String address,
  }) {
    final partners = _getOffRampPartners(profile.country.code);

    if (partners.isEmpty) {
      OffRampBottomSheet.show(this, title: l10n.ramp_btnCashOut);

      return;
    }

    final [top, ...others] = partners.unlock;

    if (others.isEmpty) {
      _launchOffRampPartner(
        top,
        profile: profile,
        address: address,
      );

      return;
    }

    RampPartnerSelectScreen.push(
      this,
      topPartner: top,
      otherPartners: others.lock,
      type: RampType.offRamp,
      onPartnerSelected: (RampPartner p) {
        Navigator.pop(this);
        _launchOffRampPartner(p, profile: profile, address: address);
      },
    );
  }

  void _launchOnRampPartner(
    RampPartner partner, {
    required ProfileData profile,
    required String address,
  }) {
    switch (partner) {
      case RampPartner.rampNetwork:
        launchRampNetworkOnRamp(profile: profile, address: address);
      case RampPartner.kado:
        launchKadoOnRamp(profile: profile, address: address);
      case RampPartner.guardarian:
        launchGuardarianOnRamp(profile: profile, address: address);
      case RampPartner.scalex:
        sl<FeatureFlagsManager>().isKycSharingEnabled()
            ? launchKycScalexOnRamp(profile: profile)
            : launchScalexOnRamp(profile: profile, address: address);
      case RampPartner.moneygram:
        launchMoneygramOnRamp(profile: profile);
      case RampPartner.coinflow:
        throw UnimplementedError('Not implemented for $partner');
    }

    sl<AnalyticsManager>()
        .rampOpened(partner: partner, rampType: RampType.onRamp.name);
  }

  void _launchOffRampPartner(
    RampPartner partner, {
    required ProfileData profile,
    required String address,
  }) {
    switch (partner) {
      case RampPartner.kado:
        launchKadoOffRamp(address: address, profile: profile);
      case RampPartner.coinflow:
        launchCoinflowOffRamp(address: address, profile: profile);
      case RampPartner.scalex:
        launchScalexOffRamp(profile: profile, address: address);
      case RampPartner.moneygram:
        launchMoneygramOffRamp(profile: profile);
      case RampPartner.rampNetwork:
      case RampPartner.guardarian:
        throw UnimplementedError('Not implemented for $partner');
    }

    sl<AnalyticsManager>()
        .rampOpened(partner: partner, rampType: RampType.offRamp.name);
  }
}

typedef PartnerOptions = ({RampPartner top, IList<RampPartner> other});

IList<RampPartner> _getOnRampPartners(String countryCode) {
  final partners = <RampPartner>{};

  if (_kadoCountries.contains(countryCode)) {
    partners.add(RampPartner.kado);
  }

  if (_scalexCountries.contains(countryCode)) {
    partners.add(RampPartner.scalex);
  }

  partners.add(RampPartner.rampNetwork);

  if (_guardarianCountries.contains(countryCode)) {
    partners.add(RampPartner.guardarian);
  }

  final isMoneygramEnabled =
      sl<FeatureFlagsManager>().isMoneygramAccessEnabled();

  if (isMoneygramEnabled && _moneygramOnRampCountries.contains(countryCode)) {
    partners.add(RampPartner.moneygram);
  }

  return IList(partners);
}

IList<RampPartner> _getOffRampPartners(String countryCode) {
  final partners = <RampPartner>{};

  if (_coinflowCountries.contains(countryCode)) {
    partners.add(RampPartner.coinflow);
  }

  if (_scalexCountries.contains(countryCode)) {
    partners.add(RampPartner.scalex);
  }

  final isMoneygramEnabled =
      sl<FeatureFlagsManager>().isMoneygramAccessEnabled();

  if (isMoneygramEnabled && _moneygramOffRampCountries.contains(countryCode)) {
    partners.add(RampPartner.moneygram);
  }

  return IList(partners);
}

const _kadoCountries = {'US'};

const _guardarianCountries = {
  'AT', 'BE', 'BG', 'HR', 'CY', 'CZ', 'DK', 'EE', 'FI', 'FR', 'DE', 'GR', //
  'HU', 'IE', 'IT', 'LV', 'LT', 'LU', 'MT', 'NL', 'PL', 'PT', 'RO', 'SK',
  'SI', 'ES', 'SE', 'IS', 'LI', 'NO', 'CH',
};

const _coinflowCountries = {
  'AD', 'AT', 'BE', 'BG', 'HR', 'CY', 'CZ', 'DK', 'EE', 'FI', 'FR', 'DE', //
  'GR', 'HU', 'IS', 'IE', 'IT', 'LV', 'LI', 'LT', 'LU', 'MT', 'MC', 'NL', 'NO',
  'PL', 'PT', 'RO', 'SM', 'SK', 'SI', 'ES', 'SE', 'CH', 'US',
};

const _scalexCountries = {'NG'};

const _moneygramOnRampCountries = {
  'AO', 'AR', 'AU', 'BH', 'BF', 'KH', 'CA', 'CV', 'CL', 'CD', 'CI', 'DK', //
  'GM', 'DE', 'GW', 'HU', 'IE', 'JO', 'KE', 'LT', 'MW', 'NO', 'OM', 'PA', //
  'PE', 'PH', 'PL', 'SA', 'SN', 'ZA', 'SE', 'TZ', 'UG', 'GB', 'US', 'ZM',
};

const _moneygramOffRampCountries = {
  'AF', 'AL', 'AI', 'AG', 'AM', 'AO', 'AR', 'AW', 'AU', 'AT', 'BH', 'BS', //
  'BB', 'BY', 'BE', 'BZ', 'BJ', 'BM', 'BT', 'BO', 'BA', 'BW', 'BR', 'BN', //
  'BF', 'BG', 'KH', 'CM', 'CA', 'CV', 'KY', 'CF', 'TD', 'CL', 'CO', 'KM', //
  'CD', 'CG', 'CR', 'CI', 'HR', 'CW', 'CY', 'CZ', 'DK', 'DJ', 'DM', 'DO', //
  'EC', 'SV', 'EE', 'ET', 'FJ', 'FI', 'FR', 'GF', 'GA', 'GM', 'GE', 'DE', //
  'GH', 'GI', 'GR', 'GD', 'GP', 'GU', 'GT', 'GW', 'GY', 'HT', 'HN', 'HK', //
  'HU', 'IS', 'IN', 'ID', 'IE', 'IL', 'IT', 'JM', 'JP', 'JO', 'KZ', 'KE', //
  'KR', 'XK', 'KG', 'LA', 'LV', 'LB', 'LR', 'LY', 'LT', 'LU', 'MK', 'MG', //
  'MW', 'MY', 'MV', 'ML', 'MT', 'MH', 'MQ', 'MR', 'MU', 'YT', 'MX', 'FM', //
  'MD', 'MN', 'ME', 'MS', 'MZ', 'MM', 'NA', 'NL', 'NZ', 'NI', 'NE', 'NG', //
  'NO', 'OM', 'PS', 'PA', 'PY', 'PE', 'PH', 'PL', 'PT', 'PR', 'RO', 'RW', //
  'RE', 'KN', 'LC', 'MF', 'VC', 'WS', 'ST', 'SA', 'SN', 'RS', 'SC', 'SL', //
  'SG', 'SX', 'SK', 'SB', 'ZA', 'SS', 'ES', 'LK', 'SE', 'CH', 'TZ', 'TH', //
  'TL', 'TG', 'TO', 'TT', 'TC', 'TV', 'UG', 'UA', 'AE', 'GB', 'US', 'UY', //
  'UZ', 'VU', 'VE', 'VN', 'VG', 'VI', 'ZM',
};
