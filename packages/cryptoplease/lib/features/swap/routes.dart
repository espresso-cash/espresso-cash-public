import 'package:auto_route/auto_route.dart';

import 'src/flow.dart';
import 'src/swap/process_swap_screen.dart';

const swapRoutes = [
  AutoRoute<void>(page: SwapFlowScreen),
  AutoRoute<void>(page: ProcessSwapScreen),
];
