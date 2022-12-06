import 'package:auto_route/auto_route.dart';

import 'src/presentation/ot_confirmation_screen.dart';
import 'src/presentation/ot_screen.dart';
import 'src/presentation/share_links_screen.dart';

const otRoutes = [
  AutoRoute<void>(page: OutgoingTipScreen),
  AutoRoute<void>(page: OTPConfirmationScreen),
  AutoRoute<void>(page: ShareLinkScreen),
];
