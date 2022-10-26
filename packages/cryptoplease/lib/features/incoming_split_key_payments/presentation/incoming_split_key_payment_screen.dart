import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/incoming_split_key_payment.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/iskp_bloc.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/iskp_repository.dart';
import 'package:cryptoplease/ui/transfer_status/transfer_error.dart';
import 'package:cryptoplease/ui/transfer_status/transfer_progress.dart';
import 'package:cryptoplease/ui/transfer_status/transfer_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomingSplitKeyPaymentScreen extends StatefulWidget {
  const IncomingSplitKeyPaymentScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<IncomingSplitKeyPaymentScreen> createState() =>
      _IncomingSplitKeyPaymentScreenState();
}

class _IncomingSplitKeyPaymentScreenState
    extends State<IncomingSplitKeyPaymentScreen> {
  late final Stream<IncomingSplitKeyPayment?> _payment;

  @override
  void initState() {
    super.initState();
    _payment = sl<ISKPRepository>().watch(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IncomingSplitKeyPayment?>(
        stream: _payment,
        builder: (context, state) {
          final payment = state.data;

          return BlocBuilder<ISKPBloc, ISKPState>(
            builder: (context, state) {
              if (payment == null) return const TransferProgress();
              if (state.contains(payment.id)) return const TransferProgress();

              return payment.status.maybeMap(
                success: (_) => TransferSuccess(
                  onOkPressed: () => context.router.pop(),
                ),
                orElse: () => TransferError(
                  onBack: () => context.router.pop(),
                  onRetry: () => context
                      .read<ISKPBloc>()
                      .add(ISKPEvent.process(payment.id)),
                ),
              );
            },
          );
        },
      );
}
