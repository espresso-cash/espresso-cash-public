import 'package:auto_route/auto_route.dart';

import 'flow.dart';
import 'swap/process_swap_screen.dart';

const swapRoutes = [
  AutoRoute<void>(page: SwapFlowScreen),
  AutoRoute<void>(page: ProcessSwapScreen),
];
