import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';

import '../../../../l10n/l10n.dart';
import '../../../ui/pages/instructions_desktop_page.dart';
import '../../../ui/pages/instructions_mobile_page.dart';
import '../../../utils/extensions.dart';

class RequestPaymentScreen extends StatelessWidget {
  const RequestPaymentScreen(this.request, {super.key});

  final SolanaPayRequest request;

  @override
  Widget build(BuildContext context) => isMobile
      ? InstructionsMobilePage(
          actionLink: Uri.parse(request.toUrl()),
          header: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  request.label == null
                      ? context.l10n.landingRequestTitle
                      : context.l10n
                          .landingUserRequestingTitle(request.label ?? ''),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.23,
                  ),
                ),
                Text(
                  '${request.amount ?? 0} USDC',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  context.l10n.landingInstruction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          actionButtonText: 'Pay',
        )
      : InstructionsDesktopPage(
          actionLink: Uri.parse(request.toUrl()),
          title: request.headerTitle,
          subtitle: context.l10n.landingInstruction,
        );
}

extension SolanaPayRequestExt on SolanaPayRequest {
  String get headerTitle {
    final name = label;
    final amount = this.amount ?? 0;

    return name == null
        ? 'You have a request of $amount USDC'
        : '$name is requesting $amount USDC';
  }
}
