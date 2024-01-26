import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';
import '../../core/desktop.dart';
import '../../core/extensions.dart';
import '../../core/landing_widget.dart';
import '../link_payment/link_payment_screen.dart';

class RequestPaymentScreen extends StatelessWidget {
  const RequestPaymentScreen(this.request, {super.key});

  final SolanaPayRequest request;

  @override
  Widget build(BuildContext context) {
    final actionLink = Uri.parse(request.toUrl());

    return isMobile
        ? MobileView(
            actionLink: actionLink,
            actionButtonText: request.actionText,
            title: request.headerTitle,
          )
        : EspressoDesktopView(
            actionLink: actionLink,
            header: HeaderDesktop(
              title: request.headerTitle,
            ),
          );
  }
}

extension on SolanaPayRequest {
  String get headerTitle {
    final name = label;
    final amount = this.amount ?? 0;

    return name == null
        ? 'You have a request of $amount USDC'
        : '$name has requested $amount USDC';
  }

  String get actionText {
    final name = label;

    return name == null ? 'Pay' : 'Pay $name';
  }
}
