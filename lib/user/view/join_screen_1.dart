import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/const/error.dart';
import 'package:wepick/common/layout/component/custom_error_pop.dart';
import 'package:wepick/common/utils/validationUtil.dart';
import 'package:wepick/user/view/join_screen_2.dart';

import '../../common/layout/component/custom_text_form_field.dart';
import '../../common/layout/default_layout.dart';

class JoinScreen extends StatefulWidget {
  static String get routeName => "join";
  const JoinScreen({Key? key}) : super(key: key);

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    String userNm = '';
    String userId = '';
    String userPw = '';
    String userPwConfirm = '';
    String userAddress = '';
    String userEmail = '';
    String userPhoneNum = '';
    String userPhone1 = '';
    String userPhone2 = '';
    String userPhone3 = '';

    return DefaultLayout(
      title: '회원가입 1/2',
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // manual : done을 눌렀을 때 키보드 비활성
        // onDrag : 드래그 하면
        child: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.s,
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
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        maxLength: 3,
                        hintText: '앞자리',
                        onChanged: (String value) {
                          userPhone1 = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text('-'),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        maxLength: 4,
                        hintText: '가운데',
                        onChanged: (String value) {
                          userPhone2 = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text('-'),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        maxLength: 4,
                        hintText: '뒷자리',
                        onChanged: (String value) {
                          userPhone3 = value;
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    userPhoneNum = userPhone1 + userPhone2 + userPhone3;

                    String? valid = checkValid(userNm, userId, userPw,
                        userPwConfirm, userAddress, userEmail, userPhoneNum);

                    // Todo 회원가입 버튼 동작 작성하기
                    if (false) {
                      if (valid != null)
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
                      context.pushNamed(JoinScreen2.routeName);
                    }
                  },
                  child: const Text('회원가입 2/2'),
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
      print('valid >> 비밀번호 ${validPw}');
      return validPw;
    }

    // 전화번호 형식 확인
    String? validPhone = ValidUtil.validPhoneNumberFormat(userPhoneNum);

    if (validPhone != null) {
      print('valid >> 전화번호 : ${validPhone}');
      return validPhone;
    }

    // 이메일 정규식 확인

    String? validEmail = ValidUtil.validEmailFormat(userEmail);

    if (validEmail != null) {
      print('valid >> 전화번호 : ${validEmail}');
      return validEmail;
    }

    return null;
  }
}
