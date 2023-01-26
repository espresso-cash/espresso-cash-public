import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/tokens/token.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import 'create_swap/create_swap_screen.dart';
import 'swap/swap_bloc.dart';
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
  void _onRouteReady(SwapRoute route) {
    final id = const Uuid().v4();
    context.read<SwapBloc>().add(SwapEvent.create(route, id));
    context.router.replace(ProcessSwapRoute(id: id));
  }

  @override
  Widget build(BuildContext context) {
    final operation = widget.inputToken == Token.usdc
        ? SwapOperation.buy
        : SwapOperation.sell;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarBrightness: Brightness.dark,
      ),
      child: CpTheme.dark(
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
      ),
    );
  }
}
