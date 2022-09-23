import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/confirm_screen/components/direct_content.dart';
import 'package:cryptoplease/features/request_pay/bl/request_pay_bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectPayConfirmScreen extends StatefulWidget {
  const DirectPayConfirmScreen({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  final ValueSetter<OutgoingTransferId> onSubmitted;

  @override
  State<DirectPayConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<DirectPayConfirmScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<RequestPayBloc, RequestPayState>(
        listenWhen: (s1, s2) => s1.processingState != s2.processingState,
        listener: (context, state) => state.processingState.maybeMap(
          error: (s) => showErrorDialog(context, 'Failed to send money', s.e),
          orElse: ignore,
        ),
        builder: (context, state) {
          print(state);

          return DirectContent(
            fee: state.fee,
            recipientAddress: state.recipient ?? '',
            tokenAmount: state.amount,
            isProcessing: state.processingState.isProcessing,
            onSubmitted: () {
              final paymentId = state.directTransfer?.paymentId;
              if (paymentId == null) return;
              widget.onSubmitted(paymentId);
            },
          );
        },
      );
}
