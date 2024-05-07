import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/home_tile.dart';
import '../../../ui/theme.dart';
import '../../balances/data/tokens_repository.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: sl<TokensRepository>(),
        builder: (context, tokens, child) {
          if (tokens.isEmpty) return const SizedBox.shrink();

          return HomeTile(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    context.l10n.cryptoPortfolio,
                    style: dashboardSectionTitleTextStyle,
                  ),
                ),
                const SizedBox(height: 16),
                ...tokens.entries.map(
                  (entry) => _TokenItem(
                    token: entry.key,
                    amount: entry.value,
                  ),
                ),
              ],
            ),
          );
        },
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem({required this.token, required this.amount});

  final Token token;
  final CryptoAmount amount;

  static const double _iconSize = 36.0;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(_iconSize / 2),
            child: ColoredBox(
              color: CpColors.darkBackground,
              child: TokenIcon(token: token, size: _iconSize),
            ),
          ),
          title: Text(
            token.name,
            style: const TextStyle(
              color: Color(0xFF2D2B2C),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            amount.format(context.locale, maxDecimals: 2),
            style: const TextStyle(
              color: Color(0xFF2D2B2C),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
