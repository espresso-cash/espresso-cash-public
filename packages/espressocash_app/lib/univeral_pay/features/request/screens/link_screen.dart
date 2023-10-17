import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/snackbar.dart';
import '../../../core/page.dart';
import '../../../core/request_helpers.dart';
import '../../../routes.gr.dart';
import '../../verifier/widgets/request_verifier.dart';
import '../../verifier/widgets/timeline_status.dart';

@RoutePage()
class RequestLinkScreen extends StatelessWidget {
  const RequestLinkScreen({
    super.key,
    @queryParam this.amount,
    @queryParam this.receiver,
    @queryParam this.reference,
  });

  static const route = RequestLinkRoute.new;

  final String? amount;
  final String? receiver;
  final String? reference;

  @override
  Widget build(BuildContext context) {
    final request = context.createUniversalRequest(
      amount: amount!,
      receiver: receiver!,
      reference: reference!,
    );

    final link = request.toUniversalPayLink().toString();

    return PaymentRequestVerifier(
      paymentRequest: request,
      child: PageWidget(
        statusWidget: TimelineStatus(request),
        children: [
          const SizedBox(height: 16),
          const Text(
            'Payment Link',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 450,
            child: CpRoundedRectangle(
              padding: const EdgeInsets.all(8),
              backgroundColor: Colors.black,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        link,
                        style: const TextStyle(
                          color: Color(0xFFFFCC17),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CpButton(
                      text: context.l10n.copy,
                      minWidth: 80,
                      onPressed: () {
                        final data = ClipboardData(text: link);
                        Clipboard.setData(data);
                        showClipboardSnackbar(context);
                      },
                      size: CpButtonSize.micro,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Share this link with person that will make the payment.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.19,
            ),
          ),
        ],
      ),
    );
  }
}
