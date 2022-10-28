import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/theme.dart';
import 'qr_scanner_bloc.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => sl<QrScannerBloc>(),
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
  bool _flashStatus = false;

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
    _qrViewController.resumeCamera();
  }

  void _onQRToggleFlash() {
    _qrViewController.toggleFlash().then((_) {
      setState(() {
        _flashStatus = !_flashStatus;
      });
    });
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
              body: Stack(
                children: [
                  QRView(
                    key: _qrKey,
                    overlay: QrScannerOverlayShape(
                      cutOutSize: 250,
                      borderColor: Colors.transparent,
                      cutOutBottomOffset: 80,
                    ),
                    onQRViewCreated: _onQRViewCreated,
                    onPermissionSet: _onPermissionSet,
                  ),
                  Align(
                    alignment: const Alignment(0, -0.3),
                    child: Assets.images.qrFrame.svg(
                      height: 250,
                      alignment: Alignment.center,
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, -0.7),
                    child: GestureDetector(
                      onTap: _onQRToggleFlash,
                      child: _flashStatus
                          ? Assets.images.flashOn.svg()
                          : Assets.images.flashOff.svg(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 16,
                        right: 24,
                      ),
                      icon: const Icon(Icons.close, size: 28),
                      onPressed: _onCloseButtonPressed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late final QRViewController _qrViewController;
}
