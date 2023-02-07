import 'package:flutter/material.dart';

import '../../config.dart';
import '../../core/presentation/utils.dart';

extension BuildContextExt on BuildContext {
  void navigateToTermsOfUse() => openLink(termsUrl);

  void navigateToPrivacyPolicy() => openLink(privacyUrl);
}
