class BoolUtil {
  static bool boolFromJson(String value) {
    return value == 'true'; // Modify this based on your actual JSON structure
  }

  static String boolToJson(bool value) {
    return value.toString() ?? 'false';
  }
}
