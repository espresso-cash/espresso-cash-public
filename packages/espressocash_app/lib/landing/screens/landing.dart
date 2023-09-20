import 'package:flutter/material.dart';

import '../../core/link_payments.dart';
import '../../core/tokens/token.dart';
import '../widgets/extensions.dart';
import 'desktop.dart';
import 'mobile.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key, required this.encodedKey});

  final String encodedKey;

  @override
  Widget build(BuildContext context) {
    final uri =
        LinkPayments(key: encodedKey, token: Token.usdc.publicKey).toUri();

    return Scaffold(
      body: isMobile ? MobileView(uri) : DesktopView(uri),
    );
  }
}
