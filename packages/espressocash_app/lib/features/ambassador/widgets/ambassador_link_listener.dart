import 'package:flutter/material.dart';

import '../../dynamic_links/widgets/dynamic_link_handler.dart';
import '../models/ambassador_referral.dart';
import 'extensions.dart';

class AmbassadorLinkListener extends StatefulWidget {
  const AmbassadorLinkListener({super.key, required this.child});

  final Widget child;

  @override
  State<AmbassadorLinkListener> createState() => _AmbassadorLinkListenerState();
}

class _AmbassadorLinkListenerState extends State<AmbassadorLinkListener> with DynamicLinkHandler {
  @override
  bool handleDynamicLink(Uri uri) {
    final referral = AmbassadorReferral.tryParse(uri.toString());
    if (referral != null) {
      context.showAmbassadorConfirmation(ambassador: referral);

      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
