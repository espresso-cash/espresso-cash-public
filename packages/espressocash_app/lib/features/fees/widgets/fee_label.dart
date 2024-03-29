import 'package:flutter/material.dart';

import '../../../core/async_snapshot.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../models/fee_type.dart';
import '../src/services/fee_calculator.dart';

class FeeLabel extends StatefulWidget {
  const FeeLabel({super.key, required this.type});

  final FeeType type;

  @override
  State<FeeLabel> createState() => _FeeLabelState();
}

class _FeeLabelState extends State<FeeLabel> {
  late final Future<String> _amount;

  @override
  void initState() {
    super.initState();
    _amount = sl<FeeCalculator>()
        .call(widget.type)
        .then((value) => value.format(context.locale));
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
        future: _amount,
        builder: (context, snapshot) {
          final String text = switch (snapshot.toResult()) {
            AsyncSnapshotLoading() => context.l10n.feesCalculating,
            AsyncSnapshotError() => context.l10n.feesFailed,
            AsyncSnapshotData(:final data) => data,
          };

          return Text(
            context.l10n.feeAmount(text),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          );
        },
      );
}
