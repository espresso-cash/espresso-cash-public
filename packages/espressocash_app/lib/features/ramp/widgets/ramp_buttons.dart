import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/l10n.dart';
import '../../../di.dart';
import '../../../ui/button.dart';
import '../../accounts/models/account.dart';
import '../../country_picker/models/country.dart';
import '../../profile/data/profile_repository.dart';
import '../coinflow.dart';
import '../src/models/profile_data.dart';
import '../src/models/ramp_partner.dart';
import '../src/models/ramp_type.dart';
import '../src/widgets/off_ramp_bottom_sheet.dart';
import '../src/widgets/partners/guardarian.dart';
import '../src/widgets/partners/kado.dart';
import '../src/widgets/partners/ramp_network.dart';
import '../src/widgets/screens/ramp_onboarding_screen.dart';
import '../src/widgets/screens/ramp_partner_select_screen.dart';

class AddCashButton extends StatelessWidget {
  const AddCashButton({
    super.key,
    this.size = CpButtonSize.normal,
  });

  final CpButtonSize size;

  @override
  Widget build(BuildContext context) => Flexible(
        child: CpButton(
          size: size,
          minWidth: 250,
          text: context.l10n.ramp_btnAddCash,
          onPressed: () async {
            final data = await context.ensureProfileData(RampType.onRamp);
            if (context.mounted && data != null) {
              context.launchOnRampFlow(
                profile: data,
                address: context.read<MyAccount>().wallet.publicKey.toBase58(),
              );
            }
          },
        ),
      );
}

class CashOutButton extends StatelessWidget {
  const CashOutButton({
    super.key,
    this.size = CpButtonSize.normal,
  });

  final CpButtonSize size;

  @override
  Widget build(BuildContext context) => Flexible(
        child: CpButton(
          size: size,
          minWidth: 250,
          text: context.l10n.ramp_btnCashOut,
          onPressed: () async {
            final data = await context.ensureProfileData(RampType.offRamp);
            if (context.mounted && data != null) {
              context.launchOffRampFlow(
                profile: data,
                address: context.read<MyAccount>().wallet.publicKey.toBase58(),
              );
            }
          },
        ),
      );
}

extension on BuildContext {
  Future<ProfileData?> ensureProfileData(RampType rampType) async {
    void handleSubmitted() {
      router.pop();
    }

    final repository = sl<ProfileRepository>();
    Country? country = repository.country?.let(Country.findByCode);
    String email = repository.email;

    if (country != null && email.isNotEmpty) {
      return (country: country, email: email);
    }

    await router.push(
      RampOnboardingScreen.route(
        onConfirmed: handleSubmitted,
        rampType: rampType,
      ),
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

    if (partners.other.isEmpty) {
      return _launchOnRampPartner(
        partners.top,
        profile: profile,
        address: address,
      );
    }

    router.push(
      RampPartnerSelectScreen.route(
        topPartner: partners.top,
        otherPartners: partners.other,
        type: RampType.onRamp,
        onPartnerSelected: (p) {
          router.pop();
          _launchOnRampPartner(p, profile: profile, address: address);
        },
      ),
    );
  }

  void launchOffRampFlow({
    required ProfileData profile,
    required String address,
  }) {
    final partners = _getOffRampPartners(profile.country.code);

    if (partners == null) {
      return unawaited(OffRampBottomSheet.show(this));
    }

    if (partners.other.isEmpty) {
      return _launchOffRampPartner(
        partners.top,
        profile: profile,
        address: address,
      );
    }

    router.push(
      RampPartnerSelectScreen.route(
        topPartner: partners.top,
        otherPartners: partners.other,
        type: RampType.offRamp,
        onPartnerSelected: (p) {
          router.pop();
          _launchOffRampPartner(p, profile: profile, address: address);
        },
      ),
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
      case RampPartner.coinflow:
        throw UnimplementedError('Not implemented for $partner');
    }
  }

  void _launchOffRampPartner(
    RampPartner partner, {
    required ProfileData profile,
    required String address,
  }) {
    switch (partner) {
      case RampPartner.coinflow:
        launchCoinflowOffRamp(profile: profile, address: address);
      case RampPartner.rampNetwork:
      case RampPartner.kado:
      case RampPartner.guardarian:
        throw UnimplementedError('Not implemented for $partner');
    }
  }
}

typedef PartnerOptions = ({RampPartner top, IList<RampPartner> other});

PartnerOptions _getOnRampPartners(String countryCode) => countryCode == 'US'
    ? (
        top: RampPartner.kado,
        other: [RampPartner.rampNetwork].lock,
      )
    : _eeaCountries.contains(countryCode)
        ? (
            top: RampPartner.guardarian,
            other: [RampPartner.rampNetwork].lock,
          )
        : (
            top: RampPartner.rampNetwork,
            other: <RampPartner>[].lock,
          );

PartnerOptions? _getOffRampPartners(String countryCode) => countryCode == 'US'
    ? (
        top: RampPartner.coinflow,
        other: <RampPartner>[].lock,
      )
    : null;

const _eeaCountries = {
  'AT', 'BE', 'BG', 'HR', 'CY', 'CZ', 'DK', 'EE', 'FI', 'FR', 'DE', 'GR', //
  'HU', 'IE', 'IT', 'LV', 'LT', 'LU', 'MT', 'NL', 'PL', 'PT', 'RO', 'SK',
  'SI', 'ES', 'SE', 'IS', 'LI', 'NO', 'CH',
};
