import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di.dart';
import '../../../../features/swap/bl/swap.dart';
import '../../../../features/swap/bl/swap/swap_bloc.dart';
import '../../../../features/swap/bl/swap/swap_repository.dart';
import '../../../../ui/transfer_status/transfer_error.dart';
import '../../../../ui/transfer_status/transfer_progress.dart';
import '../../../../ui/transfer_status/transfer_success.dart';

class ProcessSwapScreen extends StatefulWidget {
  const ProcessSwapScreen({
    Key? key,
    required this.route,
  }) : super(key: key);

  final JupiterRoute route;

  @override
  State<ProcessSwapScreen> createState() => _ProcessSwapScreenState();
}

class _ProcessSwapScreenState extends State<ProcessSwapScreen> {
  late Stream<Swap?> _swap;

  @override
  void initState() {
    super.initState();
    _swap = const Stream.empty();
    context.read<SwapBloc>().add(SwapEvent.create(widget.route));
  }

  @override
  Widget build(BuildContext context) => BlocListener<SwapBloc, SwapState>(
        listenWhen: (prev, curr) => prev.isEmpty && curr.isNotEmpty,
        listener: (_, state) {
          setState(() {
            _swap = sl<SwapRepository>().watch(state.single);
          });
        },
        child: StreamBuilder<Swap?>(
          stream: _swap,
          builder: (context, snapshot) {
            final swap = snapshot.data;

            return BlocBuilder<SwapBloc, SwapState>(
              builder: (context, state) {
                if (swap == null) return const TransferProgress();
                if (state.contains(swap.id)) return const TransferProgress();

                return swap.status.maybeMap(
                  success: (_) => TransferSuccess(
                    onOkPressed: () => context.router.pop(),
                  ),
                  orElse: () => TransferError(
                    onBack: () => context.router.pop(),
                    onRetry: () => context
                        .read<SwapBloc>()
                        .add(SwapEvent.process(swap.id)),
                  ),
                );
              },
            );
          },
        ),
      );
}
