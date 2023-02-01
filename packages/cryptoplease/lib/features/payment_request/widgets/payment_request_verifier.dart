import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/accounts/bl/account.dart';
import '../../../core/balances/refresh_balance.dart';
import '../../../di.dart';
import '../models/payment_request.dart';
import '../src/bl/payment_request_verifier/bloc.dart';

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
        create: (_) => sl<PaymentRequestVerifierBloc>(
          param1: paymentRequest,
          param2: context.read<MyAccount>().wallet.publicKey,
        ),
        lazy: false,
        child: BlocListener<PaymentRequestVerifierBloc,
            PaymentRequestVerifierState>(
          listener: (context, state) => state.whenOrNull(
            success: () => context.refreshBalances(),
          ),
          child: child,
        ),
      );
}
