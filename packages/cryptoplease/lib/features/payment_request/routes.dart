import 'package:auto_route/auto_route.dart';

import 'src/widgets/link_details/flow.dart';
import 'src/widgets/link_details/share_request.dart';
import 'src/widgets/link_request/flow.dart';

const paymentRequestRoutes = [
  AutoRoute<void>(
    page: LinkDetailsFlowScreen,
    children: [
      AutoRoute<void>(page: SharePaymentRequestScreen, initial: true),
    ],
  ),
  AutoRoute<void>(page: LinkRequestFlowScreen),
];
