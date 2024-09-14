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
