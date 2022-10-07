import 'package:cryptoplease/features/outgoing_direct_payments/bl/bloc.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/outgoing_direct_payment.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/transfer_error.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/transfer_progress.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/transfer_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final Stream<OutgoingDirectPayment?> _payment;

  @override
  void initState() {
    super.initState();
    _payment = context.read<ODPRepository>().watch(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OutgoingDirectPayment?>(
        stream: _payment,
        builder: (context, state) {
          final payment = state.data;

          return BlocBuilder<ODPBloc, ODPState>(
            builder: (context, state) {
              if (payment == null) return const TransferProgress();
              if (state.contains(payment.id)) return const TransferProgress();

              return payment.status.maybeMap(
                success: (_) => const TransferSuccess(),
                orElse: () => TransferError(
                  onRetry: () =>
                      context.read<ODPBloc>().add(ODPEvent.process(payment.id)),
                ),
              );
            },
          );
        },
      );
}
