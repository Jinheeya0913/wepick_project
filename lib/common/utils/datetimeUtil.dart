import 'package:intl/intl.dart';

class DateTimeUtil {
  static String? dateTimeToJson(DateTime? dateTime) => dateTime != null
      ? DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime)
      : null;

  static DateTime? dateTimeFromJson(String? dateTimeString) =>
      dateTimeString != null
          ? DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString)
          : null;
}
