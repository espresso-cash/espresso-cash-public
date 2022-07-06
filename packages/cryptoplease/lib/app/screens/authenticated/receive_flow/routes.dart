import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/screens/authenticated/receive_flow/request_type_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/receive_flow/share_address_screen.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_details/routes.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_request/routes.dart';

const receiveFlowRoutes = [
  AutoRoute<void>(page: RequestTypeScreen),
  AutoRoute<void>(page: ShareAddressScreen),
  linkRequestRoutes,
  ...linkDetailsRoutes,
];
