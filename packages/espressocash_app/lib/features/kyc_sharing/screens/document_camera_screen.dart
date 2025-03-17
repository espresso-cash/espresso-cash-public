import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/theme.dart';

class DocumentCameraScreen extends StatefulWidget {
  const DocumentCameraScreen({super.key});

  @override
  State<DocumentCameraScreen> createState() => _DocumentCameraScreenState();
}

class _DocumentCameraScreenState extends State<DocumentCameraScreen> {
  late CameraController _controller;
  bool _isInitialized = false;
  bool _isTakingPicture = false;

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final List<CameraDescription> cameras = await availableCameras();

      if (cameras.isEmpty) {
        _showErrorSnackBar('No camera available');

        return;
      }

      final camera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } on Exception {
      _showErrorSnackBar('Failed to initialize camera');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    showCpErrorSnackbar(
      context,
      message: message,
    );
  }

  Future<void> _takePicture() async {
    if (!_isInitialized || _isTakingPicture) return;

    setState(() => _isTakingPicture = true);

    try {
      final photo = await _controller.takePicture();

      final file = File(photo.path);

      if (!mounted) return;
      setState(() {
        _imageFile = file;
        _isTakingPicture = false;
      });
    } on Exception {
      _showErrorSnackBar('Failed to take picture');
      setState(() => _isTakingPicture = false);
    }
  }

  void _confirmImage() {
    if (_imageFile == null) return;
    Navigator.of(context).pop(_imageFile);
  }

  void _retakePicture() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          body: SafeArea(
            top: false,
            child: Stack(
              children: [
                Center(
                  child: _imageFile != null
                      ? _buildImagePreview()
                      : _buildCameraView(),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: EdgeInsets.only(
                      top: MediaQuery.paddingOf(context).top + 16,
                      right: 24,
                    ),
                    icon:
                        const Icon(Icons.close, size: 28, color: Colors.white),
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

  Widget _buildCameraView() => !_isInitialized
      ? const Center(
          child: CircularProgressIndicator(color: Colors.white),
        )
      : Stack(
          children: [
            SizedBox.expand(child: CameraPreview(_controller)),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
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
                        onPressed: _isTakingPicture ? null : _takePicture,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

  Widget _buildImagePreview() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (_imageFile case final file?)
            Image.file(
              file,
              height: double.maxFinite,
              fit: BoxFit.fitHeight,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Are you satisfied with the photo?\nIf not, please retake below.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
                CpButton(
                  variant: CpButtonVariant.light,
                  width: double.infinity,
                  text: 'Retake Document Photo',
                  onPressed: _retakePicture,
                  size: CpButtonSize.big,
                ),
                const SizedBox(height: 16),
                CpButton(
                  width: double.infinity,
                  text: 'Submit',
                  onPressed: _confirmImage,
                  size: CpButtonSize.big,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      );
}
