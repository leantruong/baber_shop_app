import 'package:intl/intl.dart';

extension DateExtension on DateTime {
 static int getDayInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

 static int getFirstDayInMonth(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday;
  }

  String formatddMMYYYY(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatMMYYYY() {
    return DateFormat('MM-yyyy').format(this);
  }

  String getNameMonth() {
    return DateFormat('MMMM yyyy').format(this);
  }
}
