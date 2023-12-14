import 'package:wepick/common/const/status.dart';

class StatusConvertUtil {
  static String statusConvert(String string) {
    print(string);
    if (string == ST_PROGRESSED) {
      return '진행중';
    } else if (string == ST_COMPLETED) {
      return '처리완료';
    } else {
      return '거절됨';
    }
  }
}
