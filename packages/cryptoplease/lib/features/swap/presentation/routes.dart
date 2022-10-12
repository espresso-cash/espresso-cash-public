import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/swap/swap_screen.dart';

const swapRoutes = [
  AutoRoute<void>(page: SwapScreen),
  // AutoRoute<void>(
  //   page: SwapFlowScreen,
  //   children: [
  //     AutoRoute<void>(page: SwapScreen, path: ''),
  //   ],
  // ),
];
