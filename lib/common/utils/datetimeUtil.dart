import 'package:intl/intl.dart';

class DateTimeUtil {
  static String? dateTimeToJson(DateTime? dateTime) =>
      dateTime != null ? _formatDateTime(dateTime) : null;

  static DateTime? dateTimeFromJson(String? dateTimeString) =>
      dateTimeString != null ? _parseDateTime(dateTimeString) : null;

  static String? _formatDateTime(DateTime? dateTime) => dateTime != null
      ? DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime)
      : null;

  static DateTime? _parseDateTime(String? dateTimeString) =>
      dateTimeString != null ? DateTime.parse(dateTimeString) : null;

  static String simpleFormatDateTime(DateTime time) =>
      DateFormat('yyyy-MM-dd').format(time);

  static int? calDDayPlus(DateTime time) {
    Duration difference = DateTime.now().difference(time);
    if (difference.isNegative) {
      return null;
    }

    return difference.inDays;
  }

  static String dateTimeToOnlyDate(DateTime date) {
    String month = '';
    String day = '';

    if (date.month < 10) {
      month = "0${date.month}";
    } else {
      month = date.month.toString();
    }

    if (date.day < 10) {
      day = "0${date.day}";
    } else {
      day = date.day.toString();
    }

    String format = "${date.year}-$month-$day";
    return format;
  }
}
