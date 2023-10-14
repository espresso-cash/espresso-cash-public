import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/payment_request/models/payment_request.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/rounded_rectangle.dart';
import '../../../ui/snackbar.dart';
import '../../core/page.dart';
import 'service/request_verifier_bloc.dart';
import 'widgets/request_verifier.dart';

class RequestLinkScreen extends StatelessWidget {
  const RequestLinkScreen(this.paymentRequest, {super.key});

  final PaymentRequest paymentRequest;

  @override
  Widget build(BuildContext context) => PaymentRequestVerifier(
        paymentRequest: paymentRequest,
        child: PageWidget(
          children: [
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
                          paymentRequest.dynamicLink,
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
                          final data =
                              ClipboardData(text: paymentRequest.dynamicLink);
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
            const SizedBox(height: 48),
            const _RequestStatus(),
          ],
        ),
      );
}

class _RequestStatus extends StatelessWidget {
  const _RequestStatus();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RequestVerifierBloc, PaymentRequestVerifierState>(
        builder: (context, state) => Column(
          children: [
            const Text(
              'Request Status',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            if (state == const PaymentRequestVerifierState.success())
              const SizedBox(
                width: 400,
                child: CpRoundedRectangle(
                  backgroundColor: CpColors.successBackgroundColor,
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                          dimension: 20,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 24),
                        Text(
                          'Payment received successfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              const SizedBox(
                width: 400,
                child: CpRoundedRectangle(
                  backgroundColor: Color(0xffF5BF00),
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 24),
                        Text(
                          'Payment not yet received',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
