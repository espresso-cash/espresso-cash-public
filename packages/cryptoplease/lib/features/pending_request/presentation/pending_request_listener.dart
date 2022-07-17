import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/solana_helpers.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/outgoing_transfer_flow.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/send_flow.dart';
import 'package:cryptoplease/features/pending_request/bl/pending_request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:solana/solana_pay.dart';

/// {@template _PendingRequestListener}
/// Listens for the Solana Pay request from the deep link and launches the
/// corresponding flow.
/// {@endtemplate}
class PendingRequestListener extends SingleChildStatefulWidget {
  /// {@macro _PendingRequestListener}
  const PendingRequestListener({
    Key? key,
    Widget? child,
    required this.routerKey,
  }) : super(key: key, child: child);

  final GlobalKey<AutoRouterState> routerKey;

  @override
  State<PendingRequestListener> createState() => _PendingRequestListenerState();
}

class _PendingRequestListenerState
    extends SingleChildState<PendingRequestListener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForPendingRequest(context.read<PendingRequestBloc>().state.request);
    });
  }

  void _checkForPendingRequest(SolanaPayRequest? request) {
    if (request == null) return;

    final token = request.token(TokenList());
    if (token == null) return;

    context.navigateToDirectTransferFt(
      onTransferCreated: (id) {
        widget.routerKey.currentState?.controller?.popUntilRoot();

        context.navigateToOutgoingTransfer(id);
      },
      initialAddress: request.recipient.toBase58(),
      token: token,
      amount: request.amount,
      memo: request.memo,
      reference: request.reference,
    );
    context
        .read<PendingRequestBloc>()
        .add(const PendingRequestEvent.consumed());
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocListener<PendingRequestBloc, PendingRequestState>(
        listener: (context, state) => _checkForPendingRequest(state.request),
        listenWhen: (s1, s2) => s1.request != s2.request,
        child: child,
      );
}
