import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bl/qr_scanner_request.dart';
import 'presentation/components/permission_dialog.dart';
import 'presentation/components/input_address_bottom_sheet.dart';
import 'qr_scanner_flow.dart';

class QrScannerFlowScreen extends StatefulWidget {
  const QrScannerFlowScreen({Key? key}) : super(key: key);

  @override
  State<QrScannerFlowScreen> createState() => _QrScannerFlowScreenState();
}

class _QrScannerFlowScreenState extends State<QrScannerFlowScreen>
    implements QrScannerFlow {
  @override
  void onCameraPermissionFailure() {
    // TODO(rhbrunetto): redirect user to input address manually
    showPermissionDialog(context, onManualInputRequested);
  }

  @override
  void onManualInputRequested() => InputAddressBottomSheet.show(context)
      .then((r) => r?.let(QrScannerRequest.parse)?.let(onScanComplete));

  @override
  void onClose() => context.router.pop();

  @override
  void onScanComplete(QrScannerRequest request) => context.router.pop(request);

  @override
  Widget build(BuildContext context) => Provider<QrScannerFlow>.value(
        value: this,
        child: const AutoRouter(),
      );
}
