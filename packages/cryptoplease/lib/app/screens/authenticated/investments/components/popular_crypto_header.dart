import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';

class PopularCryptoHeader extends StatelessWidget {
  const PopularCryptoHeader({super.key});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.popularCryptoTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 33,
              letterSpacing: .44,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.popularCryptoSubtitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: .19,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Assets.images.portfolioGraph
                .svg(fit: BoxFit.cover, alignment: Alignment.centerLeft),
          ),
        ],
      );
}
