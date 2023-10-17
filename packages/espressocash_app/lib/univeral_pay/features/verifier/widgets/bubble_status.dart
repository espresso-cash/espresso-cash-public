import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../features/transactions/services/create_transaction_link.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/text_button.dart';
import '../../verifier/service/request_verifier_bloc.dart';

class RequestStatus extends StatelessWidget {
  const RequestStatus(this.request, {super.key});

  final SolanaPayRequest request;

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
            switch (state) {
              Success(:final responses) => _Success(
                  receivedAmount: responses.first.receivedAmount,
                  txId: responses.first.signature,
                ),
              _ => const _Pending(),
            },
          ],
        ),
      );
}

class _Success extends StatelessWidget {
  const _Success({
    required this.receivedAmount,
    required this.txId,
  });

  final Decimal receivedAmount;
  final String txId;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 400,
        child: CpRoundedRectangle(
          backgroundColor: CpColors.successBackgroundColor,
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox.square(
                dimension: 20,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 24),
              Column(
                children: [
                  Text(
                    '$receivedAmount USDC received!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (txId case final tx)
                    CpTextButton(
                      variant: CpTextButtonVariant.dark,
                      text: context.l10n.moreDetails,
                      onPressed: () {
                        final link =
                            tx.let(createTransactionLink).let(Uri.parse);
                        launchUrl(link);
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      );
}

class _Pending extends StatelessWidget {
  const _Pending();

  @override
  Widget build(BuildContext context) => const SizedBox(
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
      );
}
