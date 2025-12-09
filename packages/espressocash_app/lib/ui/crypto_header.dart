import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class CpCryptoHeader extends StatefulWidget {
  const CpCryptoHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  State<CpCryptoHeader> createState() => _CpCryptoHeaderState();
}

class _CpCryptoHeaderState extends State<CpCryptoHeader> {
  RiveWidgetController? _controller;
  File? _file;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final data = await rootBundle.load('assets/rive/header.riv');
    final file = await File.decode(data.buffer.asUint8List(), riveFactory: Factory.rive);
    if (!mounted || file == null) return;

    final controller = RiveWidgetController(file);

    setState(() {
      _file = file;
      _controller = controller;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _file?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 33, letterSpacing: .44),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Text(
        widget.subtitle,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        textAlign: TextAlign.center,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: SizedBox(
          height: 120,
          child: RepaintBoundary(
            child: _controller == null
                ? const SizedBox.shrink()
                : RiveWidget(
                    controller: _controller!,
                    fit: Fit.contain,
                    alignment: Alignment.center,
                  ),
          ),
        ),
      ),
    ],
  );
}
