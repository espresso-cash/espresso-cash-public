import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:flutter/material.dart';

class BalanceOverviewWidget extends StatelessWidget {
  const BalanceOverviewWidget({
    Key? key,
    required this.balance,
    required this.checkedDate,
    this.percentageDifference,
  }) : super(key: key);

  final Amount balance;
  final DateTime checkedDate;
  final double? percentageDifference;

  static const _positiveTextColor = Color(0xff48ac1f);
  static const _negativeTextColor = Color(0xffe85c30);

  @override
  Widget build(BuildContext context) {
    final isNegative = balance.value.isNegative;
    final symbol = isNegative ? '-' : '+';

    return Center(
      child: FittedBox(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    '$symbol${balance.format(DeviceLocale.localeOf(context))}',
                style: TextStyle(
                  color: isNegative ? _negativeTextColor : _positiveTextColor,
                ),
              ),
              if (percentageDifference != null)
                TextSpan(
                  text: ' ($symbol$percentageDifference%) ',
                  style: TextStyle(
                    color: isNegative ? _negativeTextColor : _positiveTextColor,
                  ),
                ),
              const TextSpan(text: 'Today', style: TextStyle())
            ],
          ),
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),
    );
  }
}
