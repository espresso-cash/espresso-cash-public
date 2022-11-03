import 'package:auto_route/auto_route.dart';

import 'src/presentation/link_details/flow.dart';
import 'src/presentation/link_details/share_request.dart';
import 'src/presentation/link_request/flow.dart';

const paymentRequestRoutes = [
  AutoRoute<void>(
    page: LinkDetailsFlowScreen,
    children: [
      AutoRoute<void>(page: SharePaymentRequestScreen, initial: true),
    ],
  ),
  AutoRoute<void>(page: LinkRequestFlowScreen),
];
