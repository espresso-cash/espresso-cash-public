import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final now = DateTime.now();
  final showYear = now.year != date.year;

  return DateFormat('MMM d${showYear ? ' y' : ''}, hh:mm a')
      .format(date)
      .toUpperCase();
}
