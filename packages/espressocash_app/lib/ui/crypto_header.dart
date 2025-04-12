import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';

class CpCryptoHeader extends StatelessWidget {
  const CpCryptoHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 33, letterSpacing: .44),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Text(
        subtitle,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        textAlign: TextAlign.center,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: SizedBox(
          height: 120,
          child: RepaintBoundary(
            child: Assets.rive.header.rive(fit: BoxFit.contain, alignment: Alignment.center),
          ),
        ),
      ),
    ],
  );
}
