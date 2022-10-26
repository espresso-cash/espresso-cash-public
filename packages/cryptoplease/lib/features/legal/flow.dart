import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/presentation/utils.dart';
import 'package:flutter/material.dart';

extension LegalDocumentsFlowExt on BuildContext {
  void navigateToTermsOfUse() => openLink(termsUrl);

  void navigateToPrivacyPolicy() => openLink(privacyUrl);
}
