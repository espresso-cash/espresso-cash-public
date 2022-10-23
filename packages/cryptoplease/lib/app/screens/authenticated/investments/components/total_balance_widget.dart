import 'package:cryptoplease/core/balances/presentation/watch_balance.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final balance = context.watchUserTotalFiatBalance(
      context.watch<UserPreferences>().fiatCurrency,
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight + 48, bottom: 16),
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
      ),
    );
  }
}
