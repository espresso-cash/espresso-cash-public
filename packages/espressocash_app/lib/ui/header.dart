import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';

class CpHeader extends StatelessWidget {
  const CpHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 33,
              letterSpacing: .44,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: .19,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Assets.images.cryptoHeader.svg(
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ],
      );
}
