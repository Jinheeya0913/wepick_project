import 'package:wepick/common/const/status.dart';

class StatusConvertUtil {
  static String statusConvert(String string) {
    print(string);
    if (string == STAT_PROGRESSED) {
      return '진행중';
    } else if (string == STAT_COMPLETED) {
      return '처리완료';
    } else {
      return '거절됨';
    }
  }
}
