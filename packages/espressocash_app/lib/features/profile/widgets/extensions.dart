import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config.dart';

extension BuildContextExt on BuildContext {
  void launchContactUs() {
    final email = Uri.encodeComponent(contactEmail);
    final mail = Uri.parse('mailto:$email');
    launchUrl(mail);
  }
}
