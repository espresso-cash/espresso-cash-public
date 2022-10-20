import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/swap/presentation/flow.dart';
import 'package:cryptoplease/features/swap/swap_status_screen.dart';

const swapRoutes = [
  AutoRoute<void>(page: SwapFlowScreen),
  AutoRoute<void>(page: SwapStatusScreen),
];
