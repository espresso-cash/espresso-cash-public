import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/confirm_screen/confirm_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/enter_address/enter_address_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/enter_amount/enter_amount_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/pick_recipient_type/pick_recipient_type_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/qr_scanner_screen/qr_scanner_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/send_flow.dart';

const createPaymentFlowRoutes = AutoRoute<void>(
  page: SendFlowScreen,
  children: [
    AutoRoute<void>(path: '', page: PickRecipientTypeScreen),
    AutoRoute<QrScannerRequest>(page: QrScannerScreen),
    AutoRoute<void>(page: EnterAddressScreen),
    AutoRoute<void>(page: EnterAmountScreen),
    AutoRoute<void>(page: ConfirmScreen),
  ],
);
