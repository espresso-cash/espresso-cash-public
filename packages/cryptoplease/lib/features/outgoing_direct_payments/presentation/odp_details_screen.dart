import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/bloc.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/outgoing_direct_payment.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:cryptoplease/ui/transfer_status/transfer_error.dart';
import 'package:cryptoplease/ui/transfer_status/transfer_progress.dart';
import 'package:cryptoplease/ui/transfer_status/transfer_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ODPDetailsScreen extends StatefulWidget {
  const ODPDetailsScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ODPDetailsScreen> createState() => _ODPDetailsScreenState();
}

class _ODPDetailsScreenState extends State<ODPDetailsScreen> {
  late final Stream<OutgoingDirectPayment?> _payment;

  @override
  void initState() {
    super.initState();
    _payment = sl<ODPRepository>().watch(widget.id);
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
                success: (_) => TransferSuccess(
                  onOkPressed: () => context.router.pop(),
                ),
                orElse: () => TransferError(
                  onBack: () => context.router.pop(),
                  onRetry: () =>
                      context.read<ODPBloc>().add(ODPEvent.process(payment.id)),
                ),
              );
            },
          );
        },
      );
}
