import 'package:auto_route/auto_route.dart';

import 'src/presentation/otp_confirmation_screen.dart';
import 'src/presentation/otp_screen.dart';
import 'src/presentation/share_links_screen.dart';

const otpRoutes = [
  AutoRoute<void>(page: OutgoingTipScreen),
  AutoRoute<void>(page: OTPConfirmationScreen),
  AutoRoute<void>(page: ShareLinkScreen),
];
