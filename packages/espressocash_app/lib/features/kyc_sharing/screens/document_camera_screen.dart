import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';

class DocumentCameraScreen extends StatefulWidget {
  const DocumentCameraScreen({super.key});

  @override
  State<DocumentCameraScreen> createState() => _DocumentCameraScreenState();
}

class _DocumentCameraScreenState extends State<DocumentCameraScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
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
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No camera available')),
          );
        }

        return;
      }

      final camera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras.first,
      );

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to initialize camera')),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isTakingPicture) {
      return;
    }

    setState(() {
      _isTakingPicture = true;
    });

    try {
      final XFile photo = await _controller!.takePicture();

      // Create a permanent file from the XFile
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'document_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = path.join(directory.path, fileName);

      final File savedImage = File(photo.path);
      final File permanentFile = await savedImage.copy(filePath);

      setState(() {
        _imageFile = permanentFile;
        _isTakingPicture = false;
      });
    } catch (e) {
      print('Error taking picture: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to take picture')),
        );
        setState(() {
          _isTakingPicture = false;
        });
      }
    }
  }

  void _confirmImage() {
    if (_imageFile != null) {
      Navigator.of(context).pop(_imageFile);
    }
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
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(_controller!),
            ),
            const Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Take Document Photo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
          Image.file(
            _imageFile!,
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
                CpButton(
                  variant: CpButtonVariant.light,
                  width: double.infinity,
                  text: 'Retake',
                  onPressed: _retakePicture,
                ),
                const SizedBox(height: 16),
                CpButton(
                  width: double.infinity,
                  text: 'Use',
                  onPressed: _confirmImage,
                ),
              ],
            ),
          ),
        ],
      );
}
