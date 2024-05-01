import 'package:flutter/material.dart';

import '../../config.dart';
import '../../ui/web_view_screen.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (context) => const TermsScreen()),
      );

  @override
  Widget build(BuildContext context) => WebViewScreen(url: Uri.parse(termsUrl));
}
