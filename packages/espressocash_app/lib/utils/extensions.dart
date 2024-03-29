import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/l10n.dart';

// TODO(rhbrunetto): use this extension app-wide
extension StringExt on String {
  String toShortAddress() {
    if (length < 8) return this;

    return '${substring(this, 0, 4)}'
        '\u2026'
        '${substring(this, length - 4)}';
  }

  String withZeroWidthSpaces() =>
      splitMapJoin('', onMatch: (m) => '${m.group(0) ?? ''}\u200b');
}

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
