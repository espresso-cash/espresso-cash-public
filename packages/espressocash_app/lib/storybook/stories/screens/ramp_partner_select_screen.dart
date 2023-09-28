// ignore_for_file: avoid-banned-imports

import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../features/ramp/src/models/ramp_partner.dart';
import '../../../features/ramp/src/models/ramp_type.dart';
import '../../../features/ramp/src/screens/ramp_partner_select_screen.dart';
import '../../utils.dart';
import '../../utils/app_wrapper.dart';

final onRampPartnerSelectScreen = Story(
  name: 'Screens/RampPartnerSelectScreen',
  wrapperBuilder: appWrapper,
  builder: (context) => RampPartnerSelectScreen(
    topPartner: RampPartner.kado,
    otherPartners: RampPartner.values.lock.remove(RampPartner.kado),
    onPartnerSelected: ignore,
    type: context.knobs.options(
      label: 'Type',
      options: RampType.values.toOptions(),
      initial: RampType.onRamp,
    ),
  ),
);
