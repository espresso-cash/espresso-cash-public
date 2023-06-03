import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/tokens/token.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import 'create_swap/create_swap_screen.dart';
import 'swap/extensions.dart';
import 'swap_operation.dart';
import 'swap_route.dart';

@RoutePage()
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
  Future<void> _onRouteReady(SwapRoute route) async {
    final swapId = await context.createSwap(route);

    if (!mounted) return;
    await context.router.replace(ProcessSwapRoute(id: swapId));
  }

  @override
  Widget build(BuildContext context) {
    final operation = widget.inputToken == Token.usdc
        ? SwapOperation.buy
        : SwapOperation.sell;

    return CpTheme.dark(
      child: Scaffold(
        backgroundColor: CpColors.darkBackground,
        appBar: CpAppBar(
          leading: const CloseButton(),
        ),
        body: CreateSwapScreen(
          onRouteReady: _onRouteReady,
          operation: operation,
          inputToken: widget.inputToken,
          outputToken: widget.outputToken,
        ),
      ),
    );
  }
}
