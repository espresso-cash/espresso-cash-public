import 'package:dfunc/dfunc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:solana/solana_pay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../features/transactions/services/create_transaction_link.dart';
import '../../verifier/service/request_verifier_bloc.dart';

class TimelineStatus extends StatelessWidget {
  const TimelineStatus(this.request, {super.key});

  final SolanaPayRequest request;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RequestVerifierBloc, PaymentRequestVerifierState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 32),
              switch (state) {
                Success(:final responses) => _Success(responses),
                _ => _Pending(request.amount?.toString() ?? '0'),
              },
            ],
          ),
        ),
      );
}

class _Success extends StatelessWidget {
  const _Success(this.responses);
  final List<PayResponse> responses;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: responses
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${formatDate(e.timestamp)} - Payment received\n',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '${e.receivedAmount} USDC \n',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: 'View transaction',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              final link = e.signature
                                  .let(createTransactionLink)
                                  .let(Uri.parse);
                              launchUrl(link);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}

class _Pending extends StatelessWidget {
  const _Pending(this.amount);

  final String amount;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Payment not yet received\n',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '$amount USDC',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Payment processing\n',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '$amount USDC',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

String formatDate(DateTime date) => DateFormat.Hm().format(date).toUpperCase();
