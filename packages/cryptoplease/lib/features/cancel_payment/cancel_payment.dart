import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../routes.gr.dart';
import 'src/bl/bloc.dart';

extension CancelPaymentExtension on BuildContext {
  void cancelPayment(String paymentId, Ed25519HDKeyPair escrow) {
    read<PaymentCancelBloc>().add(
      PaymentCancelEvent.cancelRequested(
        paymentId: paymentId,
        escrow: escrow,
      ),
    );

    router.push(PaymentCancelRoute(paymentId: paymentId));
  }
}
