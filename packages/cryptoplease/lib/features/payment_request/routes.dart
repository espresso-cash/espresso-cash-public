import 'package:auto_route/auto_route.dart';

import 'src/presentation/link_details/flow.dart';
import 'src/presentation/link_details/share_link.dart';
import 'src/presentation/link_details/share_qr_code.dart';
import 'src/presentation/link_request/flow.dart';

const paymentRequestRoutes = [
  AutoRoute<void>(
    page: LinkDetailsFlowScreen,
    children: [
      AutoRoute<void>(page: SharePaymentRequestLinkScreen, initial: true),
      AutoRoute<void>(page: SharePaymentRequestQrCodeScreen),
    ],
  ),
  AutoRoute<void>(page: LinkRequestFlowScreen),
];
