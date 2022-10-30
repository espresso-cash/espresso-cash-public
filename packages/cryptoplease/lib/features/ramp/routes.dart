import 'package:auto_route/auto_route.dart';

import 'src/presentation/off_ramp_screen.dart';
import 'src/presentation/on_ramp_screen.dart';

const rampRoutes = [
  AutoRoute<void>(page: OnRampScreen, fullscreenDialog: true),
  AutoRoute<void>(page: OffRampScreen, fullscreenDialog: true),
];
