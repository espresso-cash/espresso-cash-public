import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/screens/authenticated/swap_flow/flow.dart';
import 'package:cryptoplease/app/screens/authenticated/swap_flow/swap_status_screen.dart';

const swapRoutes = [
  AutoRoute<void>(page: SwapFlowScreen),
  AutoRoute<void>(page: SwapStatusScreen),
];
