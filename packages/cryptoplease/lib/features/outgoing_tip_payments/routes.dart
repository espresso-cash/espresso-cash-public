import 'package:auto_route/auto_route.dart';

import 'src/presentation/ot_confirmation_screen.dart';
import 'src/presentation/ot_screen.dart';
import 'src/presentation/share_qr_screen.dart';

const outgoingTipRoutes = [
  AutoRoute<void>(page: OutgoingTipScreen),
  AutoRoute<void>(page: OTPConfirmationScreen),
  AutoRoute<void>(page: ShareQRScreen),
];
