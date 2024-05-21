import 'package:intl/intl.dart';

String yearToMonthFormatter(String a) {
  DateTime date = DateFormat("dd.MM.yy").parse(a);

  String formattedDate = DateFormat("dd MMM").format(date);

  return formattedDate;
}

bool dateComparison(String date) {
  DateTime parsedDate = DateFormat("dd.MM.yy").parse(date);

  DateTime currentDate = DateTime.now();

  bool isSameDate = parsedDate.year == currentDate.year &&
      parsedDate.month == currentDate.month &&
      parsedDate.day == currentDate.day;
  return isSameDate;
}
bool dateComparison2(String date, DateTime currentDate) {
  DateTime parsedDate = DateFormat("dd.MM.yy").parse(date);

  bool isSameDate = parsedDate.year == currentDate.year &&
      parsedDate.month == currentDate.month &&
      parsedDate.day == currentDate.day;
  return isSameDate;
}