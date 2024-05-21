import 'package:intl/intl.dart';

String yearToMonthFormatter(String a) {
  DateTime date = DateFormat("yy.MM.dd").parse(a);

  String formattedDate = DateFormat("dd MMM").format(date);

  return formattedDate;
}

bool dateComparison(String date) {
  DateTime parsedDate = DateFormat("yy.MM.dd").parse(date);

  DateTime currentDate = DateTime.now();

  bool isSameDate = parsedDate.year == currentDate.year &&
      parsedDate.month == currentDate.month &&
      parsedDate.day == currentDate.day;
  return isSameDate;
}
