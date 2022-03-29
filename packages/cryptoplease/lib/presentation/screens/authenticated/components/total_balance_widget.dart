import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:flutter/material.dart';

class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({
    Key? key,
    required this.balance,
  }) : super(key: key);

  final Amount balance;

  @override
  Widget build(BuildContext context) => Text(
        balance.format(DeviceLocale.localeOf(context)),
        style: Theme.of(context).textTheme.headline2?.copyWith(
              fontSize: 55,
              fontWeight: FontWeight.w500,
            ),
      );
}
