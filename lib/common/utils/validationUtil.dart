class ValidUtil {
  // 이메일 검증
  static String? validEmailFormat(String value) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return '잘못된 이메일 형식입니다.';
    } else {
      return null;
    }
  }

  // 전화번호 검증
  static String? validPhoneNumberFormat(String value) {
    RegExp regExp = RegExp(r'^010[0-9]{8}$');

    if (!regExp.hasMatch(value)) {
      print('검증 실패');
      return '올바른 전화번호 형식이 아닙니다';
    }
    print('검증 성공');
    return null;
  }

  static String? validPasswordFormat(String value) {
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(value)) {
      return '숫자 1개, 특수문자 1개, 대문자 1개가 포함된 8자리 이상의 비밀번호를 입력하세요';
    }
    return null;
  }

  static String? validEmailAndPhoneAndPassword(
      String email, String phone, String password) {
    String? validResult1, validResult2, validResult3 = '';

    validResult1 = validEmailFormat(email);
    validResult2 = validPhoneNumberFormat(phone);
    validResult3 = validPasswordFormat(password);

    if (validResult1 != null) {
      return validResult1;
    }

    if (validResult2 != null) {
      return validResult2;
    }

    if (validResult3 != null) {
      return validResult3;
    }

    return null;
  }
}
