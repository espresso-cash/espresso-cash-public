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
import '../../profile/data/profile_repository.dart';
import '../../profile/models/country.dart';
import '../../profile/screens/country_picker_screen.dart';
import '../kado.dart';
import '../models/ramp_partner.dart';
import '../ramp_network.dart';
import '../screens/coinflow/coinflow_withdraw_screen.dart';
import '../screens/ramp_partner_select_screen.dart';
import 'off_ramp_bottom_sheet.dart';

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
            final country = await context.ensureCountry();
            if (context.mounted) {
              context.launchOnRampFlow(
                countryCode: country.code,
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
            final country = await context.ensureCountry();
            if (context.mounted) {
              if (country.code == 'US') {
                unawaited(context.router.push(CoinflowOffRampScreen.route()));
              } else {
                unawaited(OffRampBottomSheet.show(context));
              }
            }
          },
        ),
      );
}

extension on BuildContext {
  Future<Country> ensureCountry() {
    final completer = Completer<Country>();

    void onCountrySelected(Country country) {
      router.pop();
      sl<ProfileRepository>().profile =
          sl<ProfileRepository>().profile.copyWith(country: country.code);
      completer.complete(country);
    }

    final country =
        sl<ProfileRepository>().profile.country?.let(Country.findByCode);
    if (country == null) {
      router.push(CountryPickerScreen.route(onSubmitted: onCountrySelected));
    } else {
      completer.complete(country);
    }

    return completer.future;
  }

  void launchOnRampFlow({
    required String countryCode,
    required String address,
  }) {
    final partners = _getOnRampPartners(countryCode);

    if (partners.other.isEmpty) {
      return _launchOnRampPartner(
        partners.top,
        countryCode: countryCode,
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
          _launchOnRampPartner(p, countryCode: countryCode, address: address);
        },
      ),
    );
  }

  void _launchOnRampPartner(
    RampPartner partner, {
    required String countryCode,
    required String address,
  }) {
    switch (partner) {
      case RampPartner.rampNetwork:
        launchRampNetworkOnRamp(countryCode: countryCode, address: address);
      case RampPartner.kado:
        launchKadoOnRamp(address: address);
      case RampPartner.coinflow:
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
    : (
        top: RampPartner.rampNetwork,
        other: <RampPartner>[].lock,
      );
