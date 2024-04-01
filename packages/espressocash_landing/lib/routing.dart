// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/link_payment/models/link_payment.dart';
import 'features/link_payment/screens/link_payment_screen.dart';
import 'features/payment_request/screens/request_screen.dart';
import 'utils/solana_helpers.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RootPage(),
    ),
  ],
);

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(html.window.location.toString());
    final linkPayment = LinkPayment.tryParse(uri);
    final solanaPay = tryParseSolanaPayRequest(uri);

    if (linkPayment != null) {
      return LinkPaymentScreen(linkPayment);
    } else if (solanaPay != null) {
      return RequestInitialScreen(solanaPay);
    }

    return const SizedBox.shrink();
  }
}
