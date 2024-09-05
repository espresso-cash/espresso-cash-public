import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../di.dart';
import '../../feature_flags/services/feature_flags_manager.dart';
import '../../ramp_partner/models/ramp_partner.dart';

IList<RampPartner> getOnRampPartners(String? countryCode) {
  if (countryCode == null) return IList();

  final partners = <RampPartner>{};

  final isMoneygramEnabled =
      sl<FeatureFlagsManager>().isMoneygramAccessEnabled();

  if (isMoneygramEnabled && _moneygramOnRampCountries.contains(countryCode)) {
    partners.add(RampPartner.moneygram);
  }

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

  return IList(partners);
}

IList<RampPartner> getOffRampPartners(String? countryCode) {
  if (countryCode == null) return IList();

  final partners = <RampPartner>{};

  final isMoneygramEnabled =
      sl<FeatureFlagsManager>().isMoneygramAccessEnabled();

  if (isMoneygramEnabled && _moneygramOffRampCountries.contains(countryCode)) {
    partners.add(RampPartner.moneygram);
  }

  if (_coinflowCountries.contains(countryCode)) {
    partners.add(RampPartner.coinflow);
  }

  if (_scalexCountries.contains(countryCode)) {
    partners.add(RampPartner.scalex);
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

const _moneygramOnRampCountries = {'US'};
const _moneygramOffRampCountries = {'US', 'PT'};
