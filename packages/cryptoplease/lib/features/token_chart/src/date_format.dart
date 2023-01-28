import 'package:intl/intl.dart';

String formatDate(DateTime date, {required bool showDay}) {
  final now = DateTime.now();
  final showYear = now.year != date.year;

  return DateFormat(
    '${showDay ? 'EEE' : ''} MMM d${showYear ? ' y' : ''}, hh:mm a',
  ).format(date).toUpperCase();
}
