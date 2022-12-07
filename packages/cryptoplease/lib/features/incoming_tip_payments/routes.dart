import 'package:auto_route/auto_route.dart';

import 'src/presentation/incoming_tip_screen.dart';
import 'src/presentation/tip_ready_screen.dart';

const incomingTipRoutes = [
  AutoRoute<void>(page: TipReadyScreen),
  AutoRoute<void>(page: IncomingTipScreen),
];
