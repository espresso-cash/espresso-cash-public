import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../utils/async_snapshot.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../models/fee_type.dart';
import '../services/fee_calculator.dart';

class FeeLabel extends StatefulWidget {
  const FeeLabel({
    super.key,
    required this.type,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.keyText,
    this.keyTextStyle = _defaultTextStyle,
    this.valueTextStyle = _defaultTextStyle,
  });

  final FeeType type;
  final MainAxisAlignment mainAxisAlignment;
  final String? keyText;
  final TextStyle keyTextStyle;
  final TextStyle valueTextStyle;

  @override
  State<FeeLabel> createState() => _FeeLabelState();
}

class _FeeLabelState extends State<FeeLabel> {
  late final Future<String> _amount;

  @override
  void initState() {
    super.initState();
    _amount = sl<FeeCalculator>().call(widget.type).then((value) {
      if (!mounted) return '';

      return value.format(context.locale);
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
    future: _amount,
    builder: (context, snapshot) {
      final String value = switch (snapshot.toResult()) {
        AsyncSnapshotLoading() => context.l10n.feesCalculating,
        AsyncSnapshotError() => context.l10n.feesFailed,
        AsyncSnapshotData(:final data) => data,
      };

      return Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: [
          Text(widget.keyText ?? context.l10n.fee, style: widget.keyTextStyle),
          Text(value, style: widget.valueTextStyle),
        ],
      );
    },
  );
}

const TextStyle _defaultTextStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);
