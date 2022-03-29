import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/flow.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/link_request/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/request_type_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/share_address_screen.dart';

const receiveFlowRoutes = AutoRoute<void>(
  page: ReceiveFlowScreen,
  children: [
    AutoRoute<void>(path: '', page: RequestTypeScreen),
    AutoRoute<void>(page: ShareAddressScreen),
    linkRequestRoutes,
  ],
);
