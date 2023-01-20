import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/transfer_status/transfer_error.dart';
import '../../../../ui/transfer_status/transfer_progress.dart';
import '../../../../ui/transfer_status/transfer_success.dart';
import '../bl/incoming_tip_payment.dart';
import '../bl/it_bloc.dart';
import '../bl/it_repository.dart';

class IncomingTipScreen extends StatefulWidget {
  const IncomingTipScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<IncomingTipScreen> createState() => _IncomingTipScreenState();
}

class _IncomingTipScreenState extends State<IncomingTipScreen> {
  late final Stream<IncomingTipPayment?> _payment;

  @override
  void initState() {
    super.initState();
    _payment = sl<ITRepository>().watch(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IncomingTipPayment?>(
        stream: _payment,
        builder: (context, state) {
          final payment = state.data;

          return BlocBuilder<ITBloc, ITState>(
            builder: (context, state) {
              if (payment == null) return const TransferProgress();
              if (state.contains(payment.id)) return const TransferProgress();

              return payment.status.maybeMap(
                success: (_) => TransferSuccess(
                  onOkPressed: () => context.router.pop(),
                  statusContent: context.l10n.moneyReceived,
                ),
                orElse: () => TransferError(
                  onBack: () => context.router.pop(),
                  onRetry: () =>
                      context.read<ITBloc>().add(ITEvent.process(payment.id)),
                ),
              );
            },
          );
        },
      );
}
