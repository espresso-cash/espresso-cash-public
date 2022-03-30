import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/link_request/flow.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/link_request/payer_name_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/link_request/request_amount_screen.dart';

const linkRequestRoutes = AutoRoute<void>(
  page: LinkRequestFlowScreen,
  children: [
    AutoRoute<void>(path: '', page: PayerNameScreen),
    AutoRoute<void>(page: RequestAmountScreen),
  ],
);
