import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
import 'package:provider/provider.dart';

abstract class SwapTokenRouter {
  Future<Token?> onSelectInputToken(Iterable<Token> tokens);
  Future<Token?> onSelectOutputToken(Iterable<Token> tokens);
  void onSubmit(JupiterRoute route);
}

class SwapTokenFlowScreen extends StatefulWidget {
  const SwapTokenFlowScreen({Key? key}) : super(key: key);

  @override
  State<SwapTokenFlowScreen> createState() => _SwapTokenFlowScreen();
}

class _SwapTokenFlowScreen extends State<SwapTokenFlowScreen>
    implements SwapTokenRouter {
  final routerKey = GlobalKey<AutoRouterState>();

  @override
  Future<Token?> onSelectInputToken(Iterable<Token> tokens) async {
    final route = SwapTokenSelectorRoute(
      availableTokens: tokens,
      shouldShowBalance: true,
    );

    return context.router.push<Token>(route);
  }

  @override
  Future<Token?> onSelectOutputToken(Iterable<Token> tokens) async {
    final route = SwapTokenSelectorRoute(
      availableTokens: tokens,
      shouldShowBalance: false,
    );

    return context.router.push<Token>(route);
  }

  @override
  void onSubmit(JupiterRoute route) {
    context.router.replace(SwapTokenProcessRoute(route: route));
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Provider<SwapTokenRouter>.value(
          value: this,
          child: AutoRouter(key: routerKey),
        ),
      );
}
