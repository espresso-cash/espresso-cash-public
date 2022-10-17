import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_request/flow.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_request/payer_name_screen.dart';

const linkRequestRoutes = AutoRoute<void>(
  page: LinkRequestFlowScreen,
  children: [
    AutoRoute<void>(path: '', page: PayerNameScreen),
  ],
);
