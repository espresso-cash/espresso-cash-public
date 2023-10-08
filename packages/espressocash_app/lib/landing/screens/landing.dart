import 'package:flutter/material.dart';

import '../widgets/extensions.dart';
import 'desktop.dart';
import 'mobile.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({
    super.key,
    required this.actionLink,
    required this.actionText,
    required this.title,
  });

  final Uri actionLink;
  final String actionText;
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: isMobile
            ? MobileView(
                actionLink: actionLink,
                actionText: actionText,
                title: title,
              )
            : DesktopView(
                actionLink: actionLink,
                title: title,
              ),
      );
}
