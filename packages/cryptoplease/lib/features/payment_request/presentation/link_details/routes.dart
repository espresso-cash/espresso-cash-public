import 'package:auto_route/auto_route.dart';

import 'flow.dart';
import 'share_link.dart';
import 'share_qr_code.dart';

const linkDetailsRoutes = [
  AutoRoute<void>(
    page: LinkDetailsFlowScreen,
    children: [
      AutoRoute<void>(page: SharePaymentRequestLinkScreen, initial: true),
      AutoRoute<void>(page: SharePaymentRequestQrCodeScreen),
    ],
  ),
];
