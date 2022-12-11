import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/tokens/token.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import 'create_swap/create_swap_screen.dart';
import 'swap_operation.dart';
import 'swap_route.dart';

class SwapFlowScreen extends StatefulWidget {
  const SwapFlowScreen({
    Key? key,
    required this.inputToken,
    required this.outputToken,
  }) : super(key: key);

  final Token inputToken;
  final Token outputToken;

  @override
  State<SwapFlowScreen> createState() => _FlowState();
}

class _FlowState extends State<SwapFlowScreen> {
  void _onRouteReady(SwapRoute route) => context.router.replace(
        ProcessSwapRoute(route: route),
      );

  @override
  Widget build(BuildContext context) {
    final operation = widget.inputToken == Token.usdc
        ? SwapOperation.buy
        : SwapOperation.sell;

    final String title;
    switch (operation) {
      case SwapOperation.buy:
        title = context.l10n.buyToken(widget.outputToken.name);
        break;
      case SwapOperation.sell:
        title = context.l10n.sellToken(widget.inputToken.name);
        break;
    }

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarBrightness: Brightness.dark,
      ),
      child: CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            leading: const CloseButton(),
            title: Text(title),
          ),
          body: CreateSwapScreen(
            onRouteReady: _onRouteReady,
            operation: operation,
            inputToken: widget.inputToken,
            outputToken: widget.outputToken,
          ),
        ),
      ),
    );
  }
}
