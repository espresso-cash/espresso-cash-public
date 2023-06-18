import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/crypto_header.dart';
import 'context_ext.dart';

class PopularCryptoHeader extends StatelessWidget {
  const PopularCryptoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.userHasInvestments()) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: CpCryptoHeader(
        title: context.l10n.popularCryptoTitle,
        subtitle: context.l10n.popularCryptoSubtitle,
      ),
    );
  }
}
