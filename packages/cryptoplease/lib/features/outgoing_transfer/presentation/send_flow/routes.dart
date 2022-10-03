import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/common/enter_address_screen.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/common/pick_recipient_type_screen.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/confirm_screen/confirm_screen.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/direct_transfer_flow_screen.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/enter_amount_screen.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/link_transfer_flow_screen.dart';
import 'package:cryptoplease/features/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/features/qr_scanner/qr_scanner_screen.dart';

const createPaymentFlowRoutes = [
  AutoRoute<void>(page: PickRecipientTypeScreen),
  AutoRoute<QrScannerRequest>(page: QrScannerScreen),
  AutoRoute<void>(
    page: FtDirectTransferFlowScreen,
    children: [
      AutoRoute<QrScannerRequest>(page: QrScannerScreen),
      AutoRoute<void>(page: EnterAddressScreen),
      AutoRoute<void>(page: EnterAmountScreen),
      AutoRoute<void>(page: FtConfirmScreen),
    ],
  ),
  AutoRoute<void>(
    page: FtLinkTransferFlowScreen,
    children: [
      AutoRoute<void>(page: EnterAmountScreen),
      AutoRoute<void>(page: FtConfirmScreen),
    ],
  ),
];
