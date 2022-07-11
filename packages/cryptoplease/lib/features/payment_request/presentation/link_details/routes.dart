import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_details/flow.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_details/share_link.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_details/share_qr_code.dart';

const linkDetailsRoutes = [
  AutoRoute<void>(
    page: LinkDetailsFlowScreen,
    children: [
      AutoRoute<void>(page: SharePaymentRequestLinkScreen, initial: true),
      AutoRoute<void>(page: SharePaymentRequestQrCodeScreen),
    ],
  ),
];
