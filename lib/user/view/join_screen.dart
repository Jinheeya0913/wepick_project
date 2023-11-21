import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/const/error.dart';

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
                const _Title(),
                const SizedBox(
                  height: 16.0,
                ),
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
                    final valid = checkValid(userNm, userId, userPw,
                        userPwConfirm, userAddress, userEmail, userPhoneNum);

                    // Todo 회원가입 버튼 동작 작성하기
                    if (valid != null) {
                      // 검증 실패
                      print(valid);
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
    } else if (userAddress == '') {
      return JOIN_INPUT_ADDR;
    } else if (userEmail == '') {
      return JOIN_INPUT_EMAIL;
    } else if (userPhoneNum == '') {
      return JOIN_INPUT_PHONE;
    }

    // 비밀번호 1차 2차 확인
    // 비밀번호 정규식 확인
    // 이메일 정규식 확인
    // 전화번호 정규식 확인
    //

    return null;
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '회원가입',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}
