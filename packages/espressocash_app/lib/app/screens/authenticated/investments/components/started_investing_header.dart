import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../features/token_search/widgets/discover_header.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/header.dart';
import 'context_ext.dart';

class StartedInvestingHeader extends StatelessWidget {
  const StartedInvestingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.watchUserHasInvestments()) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          CpHeader(
            title: context.l10n.startedInvestingTitle,
            subtitle: context.l10n.startedInvestingSubtitle,
          ),
          const SizedBox(height: 12),
          DiscoverHeader(
            showTitle: false,
            onTap: (it) => context.router.push(TokenSearchRoute(category: it)),
          ),
        ],
      ),
    );
  }
}
