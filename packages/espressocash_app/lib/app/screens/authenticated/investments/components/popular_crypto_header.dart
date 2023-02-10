import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/header.dart';
import 'context_ext.dart';

class PopularCryptoHeader extends StatelessWidget {
  const PopularCryptoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.watchUserHasInvestments()) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: CpHeader(
        title: context.l10n.popularCryptoTitle,
        subtitle: context.l10n.popularCryptoSubtitle,
      ),
    );
  }
}
