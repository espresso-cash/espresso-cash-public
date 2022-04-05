import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => QrScannerBloc(),
        child: const _Content(),
      );
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  late final StreamSubscription<Barcode> _subscription;

  @override
  void initState() {
    super.initState();
    context.read<QrScannerBloc>().add(const QrScannerEvent.initialized());
  }

  @override
  void dispose() {
    super.dispose();
    _qrViewController.dispose();
    _subscription.cancel();
  }

  void _onQRScanError() {
    showWarningDialog(
      context,
      title: context.l10n.qrCodeScanErrorTitle,
      message: context.l10n.qrCodeScanErrorContent,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    final bloc = context.read<QrScannerBloc>();

    _subscription = controller.scannedDataStream.listen((scanData) {
      final code = scanData.code;
      if (code != null) {
        // Once we read it, let's stop this immediately. Otherwise
        // it keeps filling up memory until the system kills the app
        _subscription.cancel();
        bloc.add(QrScannerEvent.received(code));
      }
    });

    _qrViewController = controller;
  }

  void _onBlocChange(BuildContext context, QrScannerState state) {
    state.map(
      initial: (_) {},
      done: (d) {
        _qrViewController.stopCamera();
        context.router.pop(d.request);
      },
      error: (_) {
        _qrViewController.stopCamera();
        _onQRScanError();

        context.router.pop();
      },
    );
  }

  void _onCloseButtonPressed() {
    _qrViewController.stopCamera();
    context.router.pop();
  }

  Future<void> _onPermissionSet(QRViewController _, bool allowed) async {
    if (!allowed) {
      await showWarningDialog(
        context,
        title: context.l10n.cameraPermissionsTitle,
        message: context.l10n.cameraPermissionsContent,
      );

      await context.router.pop();
    }
  }

  @override
  Widget build(BuildContext _) => BlocListener<QrScannerBloc, QrScannerState>(
        listener: _onBlocChange,
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarBrightness: Brightness.dark,
          ),
          child: CpTheme.dark(
            child: Scaffold(
              appBar: CpAppBar(
                leading: BackButton(
                  onPressed: _onCloseButtonPressed,
                ),
                title: Text(context.l10n.scanQRTitle.toUpperCase()),
              ),
              body: Container(
                color: Colors.white,
                child: QRView(
                  key: _qrKey,
                  overlay: QrScannerOverlayShape(),
                  onQRViewCreated: _onQRViewCreated,
                  onPermissionSet: _onPermissionSet,
                ),
              ),
            ),
          ),
        ),
      );

  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late final QRViewController _qrViewController;
}
