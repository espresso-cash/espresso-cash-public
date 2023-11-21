import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';

import '../../../../di.dart';
import '../service/request_verifier_bloc.dart';

class PaymentRequestVerifier extends StatelessWidget {
  const PaymentRequestVerifier({
    super.key,
    required this.child,
    required this.paymentRequest,
  });

  final Widget child;
  final SolanaPayRequest paymentRequest;

  @override
  Widget build(BuildContext context) => BlocProvider<RequestVerifierBloc>(
        create: (_) => sl<RequestVerifierBloc>(param1: paymentRequest),
        lazy: false,
        child: child,
      );
}
