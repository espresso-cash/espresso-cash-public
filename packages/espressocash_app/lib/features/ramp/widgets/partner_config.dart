import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../ramp_partner/models/ramp_partner.dart';

IList<RampPartner> getOnRampPartners(String? countryCode) {
  if (countryCode == null) return IList();

  return const IListConst([RampPartner.brijRedirect]);
}

IList<RampPartner> getOffRampPartners(String? countryCode) {
  if (countryCode == null) return IList();

  return const IListConst([RampPartner.brijRedirect]);
}
