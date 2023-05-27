import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/icon_button.dart';
import '../models/crypto_categories.dart';

class DiscoverHeader extends StatelessWidget {
  const DiscoverHeader({
    super.key,
    this.selected,
    this.showTitle = true,
    required this.onTap,
  });

  final bool showTitle;
  final CryptoCategories? selected;
  final ValueSetter<CryptoCategories> onTap;

  @override
  Widget build(BuildContext context) {
    final selected = this.selected;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (selected == null && showTitle)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                context.l10n.discover,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
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
            Row(
              children: [
                CpButton(
                  text: selected.label,
                  size: CpButtonSize.small,
                  onPressed: () => onTap.call(selected),
                  variant: CpButtonVariant.inverted,
                ),
                const SizedBox(width: 8),
                CpIconButton(
                  icon: Assets.icons.closeButtonIcon.svg(),
                  onPressed: () => onTap.call(selected),
                  variant: CpIconButtonVariant.dark,
                  size: CpIconButtonSize.small,
                ),
              ],
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
      case CryptoCategories.solana:
        return 'Solana Ecosystem';
      case CryptoCategories.defi:
        return 'DeFi';
      case CryptoCategories.amm:
        return 'Automated Market Maker (AMM)';
    }
  }
}
