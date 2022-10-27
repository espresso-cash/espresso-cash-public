import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension FormatDate on BuildContext {
  String formatDate(DateTime date) {
    final now = DateTime.now();
    final time = DateFormat.jm().format(date);

    return now.year == date.year &&
            now.month == date.month &&
            now.day == date.day
        ? l10n.todayAt(time)
        : l10n.activityDate(DateFormat.MMMd().format(date), time);
  }
}
