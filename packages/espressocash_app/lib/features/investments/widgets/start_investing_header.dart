import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/crypto_header.dart';
import '../../token_search/screens/token_search_screen.dart';
import '../../token_search/widgets/discover_header.dart';
import 'context_ext.dart';

class StartInvestingHeader extends StatelessWidget {
  const StartInvestingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.userHasInvestments()) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          CpCryptoHeader(
            title: context.l10n.startInvestingTitle,
            subtitle: context.l10n.startInvestingSubtitle,
          ),
          const SizedBox(height: 12),
          DiscoverHeader(
            showTitle: false,
            onTap: (it) =>
                context.router.push(TokenSearchScreen.route(category: it)),
          ),
        ],
      ),
    );
  }
}
