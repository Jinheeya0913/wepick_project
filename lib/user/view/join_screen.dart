import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/const/error.dart';
import 'package:wepick/common/layout/component/custom_error_pop.dart';
import 'package:wepick/common/utils/validationUtil.dart';

import '../../common/layout/component/custom_text_form_field.dart';
import '../../common/layout/default_layout.dart';

class JoinScreen extends StatelessWidget {
  static String get routeName => "join";
  const JoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userNm = '';
    String userId = '';
    String userPw = '';
    String userPwConfirm = '';
    String userAddress = '';
    String userEmail = '';
    String userPhoneNum = '';

    return DefaultLayout(
      title: '회원가입',
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // manual : done을 눌렀을 때 키보드 비활성
        // onDrag : 드래그 하면
        child: SafeArea(
          top: true,
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  hintText: '이름을 입력해주세요',
                  onChanged: (String value) {
                    userNm = value;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: 'ID를 입력해주세요',
                  onChanged: (String value) {
                    userId = value;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: '비밀번호을 입력해주세요',
                  obscureText: true,
                  onChanged: (String value) {
                    userPw = value;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: '비밀번호을 재입력해주세요',
                  obscureText: true,
                  onChanged: (String value) {
                    userPwConfirm = value;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (String value) {
                    userEmail = value;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: '주소를 입력해주세요',
                  onChanged: (String value) {
                    userAddress = value;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: '전화번호를 입력해주세요',
                  onChanged: (String value) {
                    userPhoneNum = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? valid = checkValid(userNm, userId, userPw,
                        userPwConfirm, userAddress, userEmail, userPhoneNum);

                    // Todo 회원가입 버튼 동작 작성하기
                    if (valid != null) {
                      // 검증 실패
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomErrorPop(
                              title: '회원가입 실패',
                              errorMsg: valid,
                            );
                          });
                    } else {
                      // 정상
                    }
                  },
                  child: const Text('회원가입'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? checkValid(
      String userNm,
      String userId,
      String userPw,
      String userPwConfirm,
      String userAddress,
      String userEmail,
      String userPhoneNum) {
    // 입력값 확인

    if (userNm == '') {
      return JOIN_INPUT_NAME;
    } else if (userId == '') {
      return JOIN_INPUT_ID;
    } else if (userPw == '') {
      return JOIN_INPUT_PASSWORD_1;
    } else if (userPwConfirm == '') {
      return JOIN_INPUT_PASSWORD_2;
    } else if (userPw != userPwConfirm) {
      return JOIN_INPUT_PASSWORD_NEQ;
    } else if (userEmail == '') {
      return JOIN_INPUT_EMAIL;
    } else if (userAddress == '') {
      return JOIN_INPUT_ADDR;
    } else if (userPhoneNum == '') {
      return JOIN_INPUT_PHONE;
    }

    // 비밀번호 정규식 확인
    print(userPw);
    String? validPw = ValidUtil.validPasswordFormat(userPw);

    if (validPw != null) {
      return validPw;
    }

    // 전화번호 형식 확인
    String? validPhone = ValidUtil.validPasswordFormat(userPhoneNum);

    if (validPhone != null) {
      return validPhone;
    }

    // 이메일 정규식 확인

    String? validEmail = ValidUtil.validEmailFormat(userEmail);

    if (validEmail != null) {
      return validEmail;
    }

    print(validPw);

    return null;
  }
}
