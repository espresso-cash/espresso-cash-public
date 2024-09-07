import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/theme.dart';

class KycCameraScreen extends StatefulWidget {
  const KycCameraScreen({super.key});

  @override
  State<KycCameraScreen> createState() => _KycCameraScreenState();
}

class _KycCameraScreenState extends State<KycCameraScreen> {
  File? _capturedImage;

  late FaceCameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FaceCameraController(
      autoCapture: false,
      defaultCameraLens: CameraLens.front,
      imageResolution: ImageResolution.low,
      onCapture: (image) {
        setState(() => _capturedImage = image);
      },
    );
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: const CpAppBar(
            title: Text('Capture Selfie'),
          ),
          body: Builder(
            builder: (context) => _capturedImage != null
                ? Center(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.file(
                          _capturedImage!,
                          width: double.maxFinite,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CpButton(
                                text: 'Recapture',
                                onPressed: () async {
                                  await _controller.startImageStream();

                                  if (!mounted) return;

                                  setState(() => _capturedImage = null);
                                },
                              ),
                              const SizedBox(width: 12),
                              CpButton(
                                text: 'Submit',
                                onPressed: () {
                                  Navigator.of(context).pop(_capturedImage);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SmartFaceCamera(
                    controller: _controller,
                    messageBuilder: (context, face) {
                      if (face == null) {
                        return _message('Place your face in the camera');
                      }

                      return !face.wellPositioned
                          ? _message('Center your face in the square')
                          : const SizedBox.shrink();
                    },
                  ),
          ),
        ),
      );

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
