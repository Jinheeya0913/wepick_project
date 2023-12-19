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
}
