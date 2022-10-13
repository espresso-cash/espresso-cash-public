import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/swap/presentation/flow.dart';

const swapRoutes = [
  AutoRoute<void>(page: SwapFlowScreen),
  // AutoRoute<void>(
  //   page: SwapFlowScreen,
  //   children: [
  //     AutoRoute<void>(page: SwapScreen, path: ''),
  //   ],
  // ),
];
