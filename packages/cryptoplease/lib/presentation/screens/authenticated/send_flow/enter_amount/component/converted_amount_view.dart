import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:flutter/material.dart';

class ConvertedAmountView extends StatelessWidget {
  const ConvertedAmountView({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final Amount? amount;

  @override
  Widget build(BuildContext context) {
    final formatted = amount?.format(DeviceLocale.localeOf(context));
    if (formatted == null) {
      return const SizedBox();
    }

    return Text(
      '\u2248 $formatted',
      maxLines: 1,
      style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 21),
    );
  }
}
