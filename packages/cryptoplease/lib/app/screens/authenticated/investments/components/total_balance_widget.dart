import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/balances/presentation/watch_balance.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/user_preferences.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/colors.dart';

class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final balance = context.watchUserTotalFiatBalance(
      context.watch<UserPreferences>().fiatCurrency,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.l10n.cryptoInvestments,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: CpColors.menuPrimaryTextColor,
            ),
          ),
          Text(
            balance.format(DeviceLocale.localeOf(context)),
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: CpColors.menuPrimaryTextColor,
                ),
          ),
        ],
      ),
    );
  }
}
