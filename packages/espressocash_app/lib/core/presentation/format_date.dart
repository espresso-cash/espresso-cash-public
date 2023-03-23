import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/l10n.dart';

extension FormatDate on BuildContext {
  String formatDate(DateTime date) {
    final now = DateTime.now();
    final time = DateFormat.jm().format(date);

    return now.year == date.year &&
            now.month == date.month &&
            now.day == date.day
        ? l10n.todayAt(time)
        : DateFormat.MMMd().add_jm().format(date);
  }
}
