import 'package:auto_route/auto_route.dart';

import 'src/widgets/ot_confirmation_screen.dart';
import 'src/widgets/ot_screen.dart';
import 'src/widgets/share_qr_screen.dart';

const outgoingTipRoutes = [
  AutoRoute<void>(page: OutgoingTipScreen),
  AutoRoute<void>(page: OTConfirmationScreen),
  AutoRoute<void>(page: ShareQRScreen),
];
