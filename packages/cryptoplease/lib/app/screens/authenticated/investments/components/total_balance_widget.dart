import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/balances/presentation/watch_balance.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/user_preferences.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../ui/colors.dart';

class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final balance = context.watchUserTotalFiatBalance(
      context.watch<UserPreferences>().fiatCurrency,
    );

    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          balance.format(DeviceLocale.localeOf(context)),
          style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: 57.5,
                fontWeight: FontWeight.w700,
                color: CpColors.menuPrimaryTextColor,
              ),
        ),
      ),
    );
  }
}
