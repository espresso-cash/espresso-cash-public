import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/dialogs.dart';
import 'bl/qr_scanner_request.dart';
import 'qr_scanner_flow.dart';

class QrScannerFlowScreen extends StatefulWidget {
  const QrScannerFlowScreen({Key? key}) : super(key: key);

  @override
  State<QrScannerFlowScreen> createState() => _QrScannerFlowScreenState();
}

class _QrScannerFlowScreenState extends State<QrScannerFlowScreen>
    implements QrScannerFlow {
  @override
  Future<void> onCameraPermissionFailure() async {
    // TODO(rhbrunetto): redirect user to input address manually
    await showWarningDialog(
      context,
      title: context.l10n.cameraPermissionsTitle,
      message: context.l10n.cameraPermissionsContent,
    );

    await context.router.pop();
  }

  @override
  void onInputComplete(String address) =>
      context.router.pop(QrScannerRequest.parse(address));

  @override
  void onManualInputRequested() =>
      context.router.replace(const InputAddressRoute());

  @override
  void onScanRequested() => context.router.replace(const QrScannerRoute());

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
