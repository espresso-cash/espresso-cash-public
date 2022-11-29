import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';

enum CryptoCategories {
  ethereum,
  stablecoins,
  defi,
  wrappedTokens,
  solana,
}

class DiscoverHeader extends StatelessWidget {
  const DiscoverHeader({
    super.key,
    this.selected,
    required this.onTap,
  });

  final CryptoCategories? selected;
  final void Function(CryptoCategories) onTap;

  @override
  Widget build(BuildContext context) {
    final selected = this.selected;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (selected == null) ...[
            Text(
              context.l10n.discover,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (selected == null)
            Wrap(
              runSpacing: 4,
              spacing: 4,
              children: CryptoCategories.values
                  .map(
                    (e) => CpButton(
                      text: e.label,
                      size: CpButtonSize.small,
                      onPressed: () => onTap.call(e),
                    ),
                  )
                  .toList(),
            )
          else
            CpButton(
              text: selected.label,
              size: CpButtonSize.small,
              onPressed: () => onTap.call(selected),
            )
        ],
      ),
    );
  }
}

extension on CryptoCategories {
  String get label {
    switch (this) {
      case CryptoCategories.ethereum:
        return 'Ethereum';
      case CryptoCategories.stablecoins:
        return 'Stablecoins';
      case CryptoCategories.wrappedTokens:
        return 'Wrapped-Tokens';
      case CryptoCategories.solana:
        return 'Solana Ecosystem';
      case CryptoCategories.defi:
        return 'DeFi';
    }
  }
}
