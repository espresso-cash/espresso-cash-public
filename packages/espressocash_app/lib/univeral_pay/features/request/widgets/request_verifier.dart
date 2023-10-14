import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

import '../../../../features/payment_request/models/payment_request.dart';
import '../service/request_verifier_bloc.dart';

class PaymentRequestVerifier extends StatelessWidget {
  const PaymentRequestVerifier({
    super.key,
    required this.child,
    required this.paymentRequest,
  });

  final Widget child;
  final PaymentRequest paymentRequest;

  @override
  Widget build(BuildContext context) => BlocProvider<RequestVerifierBloc>(
        create: (_) => RequestVerifierBloc(
          solanaClient: context.read<SolanaClient>(),
          request: paymentRequest,
        ),
        lazy: false,
        child: child,
      );
}
