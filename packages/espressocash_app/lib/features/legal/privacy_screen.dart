import 'package:flutter/material.dart';

import '../../config.dart';
import '../../ui/web_view_screen.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (context) => const PrivacyScreen()),
      );

  @override
  Widget build(BuildContext context) =>
      WebViewScreen(url: Uri.parse(privacyUrl));
}
