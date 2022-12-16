import 'package:auto_route/auto_route.dart';

import 'src/bl/qr_scanner_request.dart';
import 'src/presentation/qr_scanner_screen.dart';
import 'src/qr_scanner_flow_screen.dart';

const qrScannerRoutes = [
  AutoRoute<QrScannerRequest>(
    page: QrScannerFlowScreen,
    children: [
      AutoRoute(path: '', page: QrScannerScreen),
    ],
  ),
];
