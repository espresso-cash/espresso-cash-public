import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension FormatDate on BuildContext {
  String formatDate(DateTime date) => l10n.activityDate(
        DateFormat.MMMd().format(date),
        DateFormat.jm().format(date),
      );
}
