import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../routes.gr.dart';
import 'src/bl/bloc.dart';

extension CancelOutgoingPaymentExt on BuildContext {
  void cancelOutgoingPayment(String paymentId, Ed25519HDKeyPair escrow) {
    read<COPBloc>().add(
      COPEvent.cancelRequested(paymentId: paymentId, escrow: escrow),
    );

    router.push(COPRoute(paymentId: paymentId));
  }
}
