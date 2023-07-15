import 'package:flutter/material.dart';

import '../../../core/presentation/value_stream_builder.dart';
import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/crypto_header.dart';
import '../services/watch_user_has_investments.dart';

class PopularCryptoHeader extends StatelessWidget {
  const PopularCryptoHeader({super.key});

  @override
  Widget build(BuildContext context) => ValueStreamBuilder(
        create: () => sl<WatchUserHasInvestments>().call(),
        builder: (context, hasInvestments) => !hasInvestments
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(24),
                child: CpCryptoHeader(
                  title: context.l10n.popularCryptoTitle,
                  subtitle: context.l10n.popularCryptoSubtitle,
                ),
              ),
      );
}
