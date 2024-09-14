import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/button.dart';
import '../../../ui/icon_button.dart';
import '../../accounts/models/account.dart';
import '../../analytics/analytics_manager.dart';
import '../../country_picker/models/country.dart';
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
import '../screens/ramp_onboarding_screen.dart';
import '../screens/ramp_partner_select_screen.dart';

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
    RampPartnerSelectScreen.push(
      this,
      type: RampType.onRamp,
      onPartnerSelected: (RampPartner partner) {
        Navigator.pop(this);
        _launchOnRampPartner(partner, profile: profile, address: address);
      },
    );
  }

  void launchOffRampFlow({
    required ProfileData profile,
    required String address,
  }) {
    RampPartnerSelectScreen.push(
      this,
      type: RampType.offRamp,
      onPartnerSelected: (RampPartner partner) {
        Navigator.pop(this);
        _launchOffRampPartner(partner, profile: profile, address: address);
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
        launchScalexOnRamp(profile: profile, address: address);
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
