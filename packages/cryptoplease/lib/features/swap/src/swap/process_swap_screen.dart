import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/utils.dart';
import '../../../../core/transactions/create_transaction_link.dart';
import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/transfer_status/transfer_error.dart';
import '../../../../ui/transfer_status/transfer_progress.dart';
import '../../../../ui/transfer_status/transfer_success.dart';
import '../../models/swap.dart';
import 'swap_bloc.dart';
import 'swap_repository.dart';

class ProcessSwapScreen extends StatefulWidget {
  const ProcessSwapScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<ProcessSwapScreen> createState() => _ProcessSwapScreenState();
}

class _ProcessSwapScreenState extends State<ProcessSwapScreen> {
  late final Stream<Swap?> _swap;

  @override
  void initState() {
    super.initState();
    _swap = sl<SwapRepository>().watch(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Swap?>(
        stream: _swap,
        builder: (context, snapshot) {
          final swap = snapshot.data;

          return BlocBuilder<SwapBloc, SwapState>(
            builder: (context, state) {
              if (swap == null) return const TransferProgress();
              if (state.contains(swap.id)) return const TransferProgress();

              return swap.status.maybeMap(
                success: (status) => TransferSuccess(
                  onMoreDetails: () {
                    final link = status.tx.id
                        .let(createTransactionLink)
                        .let(Uri.parse)
                        .toString();
                    context.openLink(link);
                  },
                  content: context.l10n.outgoingTransferSuccess,
                ),
                orElse: () => TransferError(
                  onBack: () => context.router.pop(),
                  onRetry: () =>
                      context.read<SwapBloc>().add(SwapEvent.process(swap.id)),
                ),
              );
            },
          );
        },
      );
}
