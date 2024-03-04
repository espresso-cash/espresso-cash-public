import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import '../../../di.dart';
import '../../../routing.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../../tokens/token.dart';
import '../models/swap_operation.dart';
import '../models/swap_route.dart';
import '../services/swap_service.dart';
import 'create_swap_screen.dart';
import 'process_swap_screen.dart';

class SwapFlowScreen extends StatefulWidget {
  const SwapFlowScreen({
    super.key,
    required this.inputToken,
    required this.outputToken,
  });

  final Token inputToken;
  final Token outputToken;

  @override
  State<SwapFlowScreen> createState() => _FlowState();
}

class _FlowState extends State<SwapFlowScreen> {
  Future<void> _handleRouteReady(SwapRoute route) async {
    final swapId = await context.createSwap(route);

    if (!mounted) return;
    ProcessSwapRoute(swapId).go(context);
  }

  @override
  Widget build(BuildContext context) {
    final operation = widget.inputToken == Token.usdc
        ? SwapOperation.buy
        : SwapOperation.sell;

    return CpTheme.dark(
      child: Scaffold(
        backgroundColor: CpColors.darkBackground,
        appBar: const CpAppBar(leading: CloseButton()),
        body: CreateSwapScreen(
          onRouteReady: _handleRouteReady,
          operation: operation,
          inputToken: widget.inputToken,
          outputToken: widget.outputToken,
        ),
      ),
    );
  }
}

extension on BuildContext {
  Future<String> createSwap(SwapRoute route) => runWithLoader(this, () async {
        final swap = await sl<SwapService>().create(
          route: route,
          account: read<MyAccount>().wallet,
        );

        return swap.id;
      });
}

class CreateSwapRoute extends GoRouteData {
  const CreateSwapRoute(this.$extra);

  final ({Token input, Token output}) $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SwapFlowScreen(inputToken: $extra.input, outputToken: $extra.output);
}
