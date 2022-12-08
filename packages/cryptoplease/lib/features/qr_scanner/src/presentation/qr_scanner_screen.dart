import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/theme.dart';
import '../bl/qr_scanner_bloc.dart';
import 'qr_scanner_background.dart';

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
  bool _flashStatus = false;

  @override
  void initState() {
    super.initState();
    context.read<QrScannerBloc>().add(const QrScannerEvent.initialized());
    _qrViewController = MobileScannerController();
  }

  @override
  void dispose() {
    super.dispose();
    _qrViewController.dispose();
  }

  void _onQRScanError() {
    showWarningDialog(
      context,
      title: context.l10n.qrCodeScanErrorTitle,
      message: context.l10n.qrCodeScanErrorContent,
    );
  }

  void _onQRToggleFlash() {
    _qrViewController.toggleTorch().then((_) {
      setState(() {
        _flashStatus = !_flashStatus;
      });
    });
  }

  void _onBlocChange(BuildContext context, QrScannerState state) {
    state.map(
      initial: (_) {},
      done: (d) {
        _qrViewController.stop();
        context.router.pop(d.request);
      },
      error: (_) {
        _qrViewController.stop();
        _onQRScanError();

        context.router.pop();
      },
    );
  }

  void _onCloseButtonPressed() {
    _qrViewController.stop();
    context.router.pop();
  }

  Future<void> _onPermissionSet(bool allowed) async {
    if (!allowed) {
      await showWarningDialog(
        context,
        title: context.l10n.cameraPermissionsTitle,
        message: context.l10n.cameraPermissionsContent,
      );

      await context.router.pop();
    }
  }

  void _onDetected(Barcode barcode, MobileScannerArguments? _) {
    final code = barcode.rawValue;
    if (code != null) {
      context.read<QrScannerBloc>().add(QrScannerEvent.received(code));
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
                  QrScannerBackground(
                    child: MobileScanner(
                      key: _qrKey,
                      controller: _qrViewController,
                      onDetect: _onDetected,
                      onPermissionSet: _onPermissionSet,
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
  late final MobileScannerController _qrViewController;
}
