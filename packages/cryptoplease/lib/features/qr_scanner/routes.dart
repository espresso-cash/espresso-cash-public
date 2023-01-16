import 'package:auto_route/auto_route.dart';

import 'models/qr_scanner_request.dart';
import 'src/widgets/qr_scanner_screen.dart';

const qrScannerRoutes = [
  AutoRoute<QrScannerRequest>(page: QrScannerScreen),
];
