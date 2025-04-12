import 'package:flutter/material.dart';

import '../models/ambassador_referral.dart';
import '../screens/ambassador_confirmation_screen.dart';

extension BuildContextExt on BuildContext {
  void showAmbassadorConfirmation({required AmbassadorReferral ambassador}) =>
      AmbassadorConfirmationScreen.push(this, ambassador);
}
