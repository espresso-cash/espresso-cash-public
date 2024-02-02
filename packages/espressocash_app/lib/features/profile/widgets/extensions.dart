import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config.dart';
import '../../../di.dart';
import '../../intercom/intercom_service.dart';

extension BuildContextExt on BuildContext {
  void launchContactUs() {
    final email = Uri.encodeComponent(contactEmail);
    final mail = Uri.parse('mailto:$email');
    launchUrl(mail);
  }

  void launchIntercom() => sl<IntercomService>().displayMessenger();
}
