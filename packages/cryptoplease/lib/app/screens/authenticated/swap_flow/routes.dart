import 'package:auto_route/auto_route.dart';

import 'flow.dart';
import 'process_swap_screen.dart';

const swapRoutes = [
  AutoRoute<void>(page: SwapFlowScreen),
  AutoRoute<void>(page: ProcessSwapScreen),
];
