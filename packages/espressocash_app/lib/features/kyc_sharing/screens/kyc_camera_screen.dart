import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/theme.dart';
import '../data/kyc_repository.dart';
import '../services/kyc_service.dart';
import 'bank_account_screen.dart';

// TODO(vsumin): divide complicated widgets, refactor

class KycCameraScreen extends StatefulWidget {
  const KycCameraScreen({super.key});

  static void pushReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const KycCameraScreen(),
        ),
      );

  @override
  State<KycCameraScreen> createState() => _KycCameraScreenState();
}

class _KycCameraScreenState extends State<KycCameraScreen> {
  File? _capturedImage;

  bool _isLoading = false;

  late FaceCameraController _controller;

  Future<void> _handleSubmitted() async {
    setState(() => _isLoading = true);

    try {
      final service = sl<KycSharingService>();

      await service.updateInfo(
        data: const V1UserData(),
        photo: null,
      );

      if (!mounted) return;

      showCpSnackbar(context, message: 'Success, Data updated');
      sl<KycRepository>().hasPassedKyc = true;
      BankAccountScreen.pushReplacement(context);
    } on Exception {
      showCpErrorSnackbar(context, message: 'Failed to update data');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = FaceCameraController(
      autoCapture: false,
      defaultCameraLens: CameraLens.front,
      onCapture: (image) {
        setState(() => _capturedImage = image);
      },
    );
  }

  @override
  Widget build(BuildContext context) => CpLoader(
        isLoading: _isLoading,
        child: CpTheme.black(
          child: Scaffold(
            body: Stack(
              children: [
                Builder(
                  builder: (context) => _capturedImage != null
                      ? Center(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Transform.flip(
                                flipX: true,
                                child: Image.file(
                                  _capturedImage!,
                                  height: double.maxFinite,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 16,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CpButton(
                                      variant: CpButtonVariant.light,
                                      width: double.infinity,
                                      text: 'Retake Selfie',
                                      onPressed: () async {
                                        await _controller.startImageStream();

                                        if (!mounted) return;

                                        setState(() => _capturedImage = null);
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    CpButton(
                                      width: double.infinity,
                                      text: 'Submit',
                                      onPressed: _handleSubmitted,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SmartFaceCamera(
                              controller: _controller,
                              indicatorShape: IndicatorShape.image,
                              indicatorAssetImage: Assets.images.faceFrame.path,
                              showControls: false,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: CpColors.yellowColor,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CpButton(
                                      text: '',
                                      onPressed: _controller.captureImage,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: EdgeInsets.only(
                      top: MediaQuery.paddingOf(context).top + 16,
                      right: 24,
                    ),
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
