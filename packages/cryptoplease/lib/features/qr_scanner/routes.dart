import 'package:auto_route/auto_route.dart';

import 'src/qr_scanner_request.dart';
import 'src/qr_scanner_screen.dart';

const qrScannerRoutes = [
  AutoRoute<QrScannerRequest>(page: QrScannerScreen),
];
