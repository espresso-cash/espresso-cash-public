import 'package:date_time_format/date_time_format.dart';

extension DateTimeExtension on DateTime {
  String formatDate() {
    final date = isToday() ? 'Today' : 'On ${format('M j')}';
    final time = format('h:m A');
    final year = isThisYear() ? '' : ', ${format('Y')}';

    return '$date$year at $time';
  }

  bool isToday() {
    final now = DateTime.now();

    return now.day == day && now.month == month && now.year == year;
  }

  bool isThisYear() {
    final now = DateTime.now();

    return now.year == year;
  }
}
