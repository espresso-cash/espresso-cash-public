import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/enter_address_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/pick_recipient_type_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/qr_scanner_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/confirm_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/direct_transfer_flow_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/enter_amount_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/link_transfer_flow_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/non_fungible_token/confirm_screen/confirm_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/non_fungible_token/direct_transfer_flow_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/non_fungible_token/link_transfer_flow_screen.dart';

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
  AutoRoute<void>(
    page: NftDirectTransferFlowScreen,
    children: [
      AutoRoute<QrScannerRequest>(page: QrScannerScreen),
      AutoRoute<void>(page: EnterAddressScreen),
      AutoRoute<void>(page: NftConfirmScreen),
    ],
  ),
  AutoRoute<void>(
    page: NftLinkTransferFlowScreen,
    children: [
      AutoRoute<void>(page: NftConfirmScreen),
    ],
  ),
];
