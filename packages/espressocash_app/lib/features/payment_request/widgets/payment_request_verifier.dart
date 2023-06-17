import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/balances/widgets/context_ext.dart';
import '../../../di.dart';
import '../models/payment_request.dart';
import '../services/payment_request_verifier_bloc.dart';

class PaymentRequestVerifier extends StatelessWidget {
  const PaymentRequestVerifier({
    super.key,
    required this.child,
    this.paymentRequest,
  });

  final Widget child;
  final PaymentRequest? paymentRequest;

  @override
  Widget build(BuildContext context) =>
      BlocProvider<PaymentRequestVerifierBloc>(
        create: (_) => sl<PaymentRequestVerifierBloc>(param1: paymentRequest),
        lazy: false,
        child: BlocListener<PaymentRequestVerifierBloc,
            PaymentRequestVerifierState>(
          listener: (context, state) => state.whenOrNull(
            success: () => context.notifyBalanceAffected(),
          ),
          child: child,
        ),
      );
}
